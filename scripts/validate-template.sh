#!/bin/bash

# Template validation script
set -e

echo "🔍 Starting template validation..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    if [ "$1" == "success" ]; then
        echo -e "${GREEN}✅ $2${NC}"
    elif [ "$1" == "error" ]; then
        echo -e "${RED}❌ $2${NC}"
        exit 1
    elif [ "$1" == "warning" ]; then
        echo -e "${YELLOW}⚠️  $2${NC}"
    fi
}

# Clean up previous test runs
echo "🧹 Cleaning up previous test runs..."
rm -rf test-output test-* artifacts nupkg Demo TestProject

# Build the template package
echo "📦 Building template package..."
if dotnet pack --configuration Release; then
    print_status "success" "Template package built successfully"
else
    print_status "error" "Failed to build template package"
fi

# Check if package was created
if [ -f "nupkg/ConsoleWithTests.Template.1.0.0.nupkg" ]; then
    print_status "success" "Package file created"
else
    print_status "error" "Package file not found"
fi

# Uninstall previous version if exists
echo "🔄 Uninstalling previous template version..."
dotnet new uninstall ConsoleWithTests.Template 2>/dev/null || true

# Install the template
echo "📥 Installing template..."
if dotnet new install ./nupkg/ConsoleWithTests.Template.1.0.0.nupkg; then
    print_status "success" "Template installed successfully"
else
    print_status "error" "Failed to install template"
fi

# Test template with different frameworks
frameworks=("net8.0" "net9.0")
for fw in "${frameworks[@]}"; do
    echo ""
    echo "🧪 Testing with framework: $fw"

    test_dir="test-$fw"
    project_name="Test${fw//./}"

    # Create project from template
    echo "  Creating project from template..."
    mkdir -p "$test_dir"
    cd "$test_dir"

    if dotnet new console-with-tests -n "$project_name" --Framework "$fw"; then
        print_status "success" "Project created with $fw"
    else
        print_status "error" "Failed to create project with $fw"
    fi

    cd "$project_name"

    # Check if required files exist
    echo "  Checking project structure..."
    required_files=(
        "${project_name}.sln"
        "src/App/App.csproj"
        "src/App/Program.cs"
        "tests/App.Tests/App.Tests.csproj"
        "tests/App.Tests/UnitTest1.cs"
        "tests/App.Tests/xunit.runner.json"
    )

    for file in "${required_files[@]}"; do
        if [ -f "$file" ]; then
            echo "    ✓ $file exists"
        else
            print_status "error" "$file is missing"
        fi
    done

    # Build the generated project
    echo "  Building project..."
    if dotnet build --configuration Release; then
        print_status "success" "Build succeeded for $fw"
    else
        print_status "error" "Build failed for $fw"
    fi

    # Run tests
    echo "  Running tests..."
    if dotnet test --configuration Release --no-build --verbosity minimal; then
        print_status "success" "Tests passed for $fw"
    else
        print_status "error" "Tests failed for $fw"
    fi

    # Run the console app
    echo "  Running console application..."
    if dotnet run --project src/App/App.csproj --configuration Release --no-build; then
        print_status "success" "Console app ran successfully for $fw"
    else
        print_status "error" "Failed to run console app for $fw"
    fi

    cd ../..
done

# Validate template.json
echo ""
echo "📋 Validating template configuration..."
if [ -f ".template.config/template.json" ]; then
    if jq empty .template.config/template.json 2>/dev/null; then
        print_status "success" "template.json is valid JSON"
    else
        print_status "error" "template.json is not valid JSON"
    fi
else
    print_status "error" "template.json not found"
fi

# Check for required metadata
echo "🏷️  Checking package metadata..."
required_metadata=(
    "PackageId"
    "Version"
    "Authors"
    "Description"
    "PackageLicenseExpression"
)

for metadata in "${required_metadata[@]}"; do
    if grep -q "<$metadata>" ConsoleWithTests.Template.csproj; then
        echo "  ✓ $metadata present"
    else
        print_status "warning" "$metadata missing in csproj"
    fi
done

# Final summary
echo ""
echo "========================================="
print_status "success" "Template validation completed successfully!"
echo "========================================="
echo ""
echo "📦 Package: ./nupkg/ConsoleWithTests.Template.1.0.0.nupkg"
echo "📝 To publish to NuGet:"
echo "   dotnet nuget push ./nupkg/ConsoleWithTests.Template.1.0.0.nupkg --source https://api.nuget.org/v3/index.json --api-key YOUR_API_KEY"
echo ""
# Template validation script for Windows
$ErrorActionPreference = "Stop"

Write-Host "🔍 Starting template validation..." -ForegroundColor Cyan

function Write-Status {
    param(
        [string]$Status,
        [string]$Message
    )

    switch ($Status) {
        "success" { Write-Host "✅ $Message" -ForegroundColor Green }
        "error" {
            Write-Host "❌ $Message" -ForegroundColor Red
            exit 1
        }
        "warning" { Write-Host "⚠️  $Message" -ForegroundColor Yellow }
    }
}

# Clean up previous test runs
Write-Host "🧹 Cleaning up previous test runs..." -ForegroundColor Cyan
Remove-Item -Path "test-output", "test-*", "artifacts", "nupkg", "Demo", "TestProject" -Recurse -Force -ErrorAction SilentlyContinue

# Build the template package
Write-Host "📦 Building template package..." -ForegroundColor Cyan
try {
    dotnet pack --configuration Release
    Write-Status "success" "Template package built successfully"
} catch {
    Write-Status "error" "Failed to build template package"
}

# Check if package was created
if (Test-Path "nupkg\ConsoleWithTests.Template.1.0.0.nupkg") {
    Write-Status "success" "Package file created"
} else {
    Write-Status "error" "Package file not found"
}

# Uninstall previous version if exists
Write-Host "🔄 Uninstalling previous template version..." -ForegroundColor Cyan
dotnet new uninstall ConsoleWithTests.Template 2>$null

# Install the template
Write-Host "📥 Installing template..." -ForegroundColor Cyan
try {
    dotnet new install .\nupkg\ConsoleWithTests.Template.1.0.0.nupkg
    Write-Status "success" "Template installed successfully"
} catch {
    Write-Status "error" "Failed to install template"
}

# Test template with different frameworks
$frameworks = @("net8.0", "net9.0")
foreach ($fw in $frameworks) {
    Write-Host ""
    Write-Host "🧪 Testing with framework: $fw" -ForegroundColor Cyan

    $testDir = "test-$fw"
    $projectName = "Test$($fw -replace '\.', '')"

    # Create project from template
    Write-Host "  Creating project from template..."
    New-Item -ItemType Directory -Path $testDir -Force | Out-Null
    Set-Location $testDir

    try {
        dotnet new console-with-tests -n $projectName --Framework $fw
        Write-Status "success" "Project created with $fw"
    } catch {
        Write-Status "error" "Failed to create project with $fw"
    }

    Set-Location $projectName

    # Check if required files exist
    Write-Host "  Checking project structure..."
    $requiredFiles = @(
        "$projectName.sln",
        "src\App\App.csproj",
        "src\App\Program.cs",
        "tests\App.Tests\App.Tests.csproj",
        "tests\App.Tests\UnitTest1.cs",
        "tests\App.Tests\xunit.runner.json"
    )

    foreach ($file in $requiredFiles) {
        if (Test-Path $file) {
            Write-Host "    ✓ $file exists" -ForegroundColor Green
        } else {
            Write-Status "error" "$file is missing"
        }
    }

    # Build the generated project
    Write-Host "  Building project..."
    try {
        dotnet build --configuration Release
        Write-Status "success" "Build succeeded for $fw"
    } catch {
        Write-Status "error" "Build failed for $fw"
    }

    # Run tests
    Write-Host "  Running tests..."
    try {
        dotnet test --configuration Release --no-build --verbosity minimal
        Write-Status "success" "Tests passed for $fw"
    } catch {
        Write-Status "error" "Tests failed for $fw"
    }

    # Run the console app
    Write-Host "  Running console application..."
    try {
        dotnet run --project src\App\App.csproj --configuration Release --no-build
        Write-Status "success" "Console app ran successfully for $fw"
    } catch {
        Write-Status "error" "Failed to run console app for $fw"
    }

    Set-Location ..\..
}

# Validate template.json
Write-Host ""
Write-Host "📋 Validating template configuration..." -ForegroundColor Cyan
if (Test-Path ".template.config\template.json") {
    try {
        $json = Get-Content ".template.config\template.json" -Raw | ConvertFrom-Json
        Write-Status "success" "template.json is valid JSON"
    } catch {
        Write-Status "error" "template.json is not valid JSON"
    }
} else {
    Write-Status "error" "template.json not found"
}

# Check for required metadata
Write-Host "🏷️  Checking package metadata..." -ForegroundColor Cyan
$requiredMetadata = @(
    "PackageId",
    "Version",
    "Authors",
    "Description",
    "PackageLicenseExpression"
)

$csprojContent = Get-Content "ConsoleWithTests.Template.csproj" -Raw
foreach ($metadata in $requiredMetadata) {
    if ($csprojContent -match "<$metadata>") {
        Write-Host "  ✓ $metadata present" -ForegroundColor Green
    } else {
        Write-Status "warning" "$metadata missing in csproj"
    }
}

# Final summary
Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Status "success" "Template validation completed successfully!"
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📦 Package: .\nupkg\ConsoleWithTests.Template.1.0.0.nupkg" -ForegroundColor White
Write-Host "📝 To publish to NuGet:" -ForegroundColor White
Write-Host "   dotnet nuget push .\nupkg\ConsoleWithTests.Template.1.0.0.nupkg --source https://api.nuget.org/v3/index.json --api-key YOUR_API_KEY" -ForegroundColor Gray
Write-Host ""
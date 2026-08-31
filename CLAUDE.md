# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **NuGet Template Project** that creates .NET Console Applications with integrated xUnit v3 testing. The template is distributed via NuGet package with ID `ConsoleWithTests.Template` and short name `console-with-tests`.

## Key Commands

### Template Development
```bash
# Install template locally for testing
dotnet new install .

# Create a new project from template (default .NET 10)
dotnet new console-with-tests -n MyProject

# Create with specific framework
dotnet new console-with-tests -n MyProject --framework net8.0

# Uninstall template
dotnet new uninstall ConsoleWithTests.Template

# Build Docker image with template validation
docker build -t console-with-tests-template .
```

### Generated Project Commands
When working with projects generated from this template (`global.json` opts `dotnet test` into
the Microsoft.Testing.Platform runner, so these are MTP options, not VSTest's):
```bash
# Build the solution
dotnet build

# Run tests
dotnet test

# Run tests with coverage
dotnet test --coverage --coverage-output-format cobertura --results-directory TestResults

# Run the console application
dotnet run --project src/App/App.csproj

# Run specific test
dotnet test --filter-method "*Test_Add_Returns_Correct_Sum"
```

## Architecture

### Template Structure
The template creates a solution with clean separation:
- **src/App/**: Console application with business logic
- **tests/App.Tests/**: xUnit v3 test project with sample tests demonstrating Fact and Theory patterns
- **ProjectName.sln**: Solution file linking both projects

### Key Template Files
- **.template.config/template.json**: Template metadata defining parameters (framework selection) and source name replacement
- **xunit.runner.json**: xUnit configuration with parallel execution and 10-second timeout
- **.editorconfig**: Enforces C# coding standards (interface prefix "I", modifier order, etc.)

### Framework Support
The template parameter `--framework` supports:
- `net10.0` (default)
- `net9.0`
- `net8.0`

## CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/ci-cd.yml`) runs four jobs:
1. **build-and-test**: Cross-platform testing on Ubuntu/Windows/macOS with .NET 8.0 and 9.0
2. **validate-template**: Validates template.json and tests all framework options
3. **code-quality**: Checks file formatting and template structure
4. **create-release**: Creates GitHub releases on version tags (v*)

## Testing Approach

xUnit v3 is configured with:
- Parallel test execution at assembly and collection level
- 10-second timeout for long-running tests
- Method display showing class and method names
- Coverage collection via Coverlet

Sample tests demonstrate:
- **Fact**: Simple unit tests
- **Theory with InlineData**: Parameterized testing with multiple test cases

## Docker Support

Multi-stage Dockerfile validates the template:
1. **Build stage**: Creates NuGet package
2. **Validate stage**: Installs template and tests project generation
3. **Final stage**: Outputs validated package

## Important Configuration

### Source Name Replacement
The template uses "ProjectName" as the replaceable identifier. During template instantiation, all occurrences of "ProjectName" in file names and content are replaced with the user-specified name.

### Post-Actions
The template automatically runs `dotnet restore` after project creation to ensure all dependencies are available.

### Dependabot
Configured for weekly updates of NuGet packages and GitHub Actions, with automatic labeling and assignment to maintainer "mrviduus".
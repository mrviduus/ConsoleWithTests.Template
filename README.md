# Console App with xUnit v3 Tests Template

[![NuGet Version](https://img.shields.io/nuget/v/ConsoleWithTests.Template)](https://www.nuget.org/packages/ConsoleWithTests.Template/)
[![NuGet Downloads](https://img.shields.io/nuget/dt/ConsoleWithTests.Template)](https://www.nuget.org/packages/ConsoleWithTests.Template/)
[![License](https://img.shields.io/github/license/mrviduus/ConsoleWithTests.Template)](LICENSE)
[![CI/CD](https://github.com/mrviduus/ConsoleWithTests.Template/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/mrviduus/ConsoleWithTests.Template/actions)
[![.NET](https://img.shields.io/badge/.NET-10%20%7C%209%20%7C%208-512BD4)](https://dotnet.microsoft.com/)

A production-ready .NET template that creates a console application with xUnit v3 test project structure, following best practices and clean architecture.

## Features

- ✅ Console application in `src/App`
- ✅ xUnit v3 test project in `tests/App.Tests`
- ✅ Solution file with both projects configured
- ✅ Microsoft Testing Platform integration
- ✅ Sample unit tests with Theory and Fact attributes
- ✅ Project references properly configured
- ✅ .NET 10 support (with options for .NET 9 and .NET 8)

## Installation

### Build and Install the Template

1. **Build the template package:**
   ```bash
   dotnet pack
   ```

2. **Install the template:**
   ```bash
   dotnet new install ./nupkg/ConsoleWithTests.Template.1.0.0.nupkg
   ```

## Usage

### Create a New Project

```bash
dotnet new console-with-tests -n MyProject
```

This will create the following structure:

```
MyProject/
  MyProject.sln                 # Solution file
  src/
    App/
      App.csproj               # Console application project
      Program.cs               # Main program with sample Add method
  tests/
    App.Tests/
      App.Tests.csproj         # xUnit v3 test project
      UnitTest1.cs             # Sample unit tests
      xunit.runner.json        # xUnit configuration
  README.md                    # This file
```

### Specify Target Framework

You can specify the target framework when creating a project:

```bash
# Use .NET 10 (default)
dotnet new console-with-tests -n MyProject

# Use .NET 9
dotnet new console-with-tests -n MyProject --Framework net9.0

# Use .NET 8
dotnet new console-with-tests -n MyProject --Framework net8.0
```

### Build and Test

After creating a project:

```bash
cd MyProject
dotnet build
dotnet test
```

## Template Development

### Updating the Template

1. Make changes to the template files
2. Rebuild the package: `dotnet pack`
3. Uninstall old version: `dotnet new uninstall ConsoleWithTests.Template`
4. Install new version: `dotnet new install ./nupkg/ConsoleWithTests.Template.1.0.0.nupkg`

### Template Structure

- `.template.config/template.json` - Template configuration
- `ConsoleWithTests.Template.csproj` - NuGet package project
- `src/App/` - Console application template
- `tests/App.Tests/` - Test project template
- `ProjectName.sln` - Solution file template

## Docker Support

Build and validate the template using Docker:

```bash
docker build -t console-with-tests-template .
```

## Requirements

- .NET SDK 8.0 or later (for building the template)
- .NET 10.0 SDK (for using net10.0 projects)

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Quick Start for Contributors

```bash
# Fork and clone the repository
git clone https://github.com/mrviduus/ConsoleWithTests.Template.git
cd ConsoleWithTests.Template

# Build and test locally
dotnet pack
dotnet new install ./nupkg/ConsoleWithTests.Template.1.0.0.nupkg
dotnet new console-with-tests -n TestProject

# Run validation
./scripts/validate-template.sh  # On Linux/Mac
./scripts/validate-template.ps1 # On Windows
```

## Security

Found a security issue? Please see our [Security Policy](SECURITY.md) for reporting procedures.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with ❤️ by the open-source community
- Inspired by best practices from the .NET Foundation
- Uses xUnit v3 for modern testing capabilities

## Support

- 📖 [Documentation](https://github.com/mrviduus/ConsoleWithTests.Template/wiki)
- 🐛 [Report Issues](https://github.com/mrviduus/ConsoleWithTests.Template/issues)
- 💬 [Discussions](https://github.com/mrviduus/ConsoleWithTests.Template/discussions)
- 📧 Contact: [your-email@example.com]

---

<div align="center">
  Made with ❤️ for the .NET Community
  <br>
  Star ⭐ this repository if you find it helpful!
</div>
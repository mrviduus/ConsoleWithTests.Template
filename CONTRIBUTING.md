# Contributing to ConsoleWithTests.Template

First off, thank you for considering contributing to ConsoleWithTests.Template! It's people like you that make this template a great tool for the .NET community.

## Code of Conduct

This project and everyone participating in it is governed by the [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps to reproduce the problem**
* **Provide specific examples to demonstrate the steps**
* **Describe the behavior you observed and expected**
* **Include screenshots if relevant**
* **Include your environment details** (OS, .NET version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a detailed description of the suggested enhancement**
* **Provide specific examples to demonstrate the enhancement**
* **Describe the current behavior and expected behavior**
* **Explain why this enhancement would be useful**

### Pull Requests

1. Fork the repo and create your branch from `main`
2. If you've added code that should be tested, add tests
3. If you've changed APIs, update the documentation
4. Ensure the test suite passes
5. Make sure your code follows the existing code style
6. Issue that pull request!

## Development Process

### Prerequisites

* .NET SDK 8.0 or later
* Git
* Your favorite IDE (Visual Studio, VS Code, Rider, etc.)

### Setting Up Development Environment

1. Fork and clone the repository:
   ```bash
   git clone https://github.com/YOUR-USERNAME/ConsoleWithTests.Template.git
   cd ConsoleWithTests.Template
   ```

2. Build the NuGet package:
   ```bash
   dotnet pack console-with-tests.csproj -o ./nupkg
   ```

3. Install locally for testing:
   ```bash
   dotnet new install ./nupkg/console-with-tests.1.0.0.nupkg
   ```

4. Test the template:
   ```bash
   dotnet new console-with-tests -n TestProject
   cd TestProject
   dotnet build
   dotnet test
   ```

### Project Structure

```
ConsoleWithTests.Template/
├── .template.config/
│   └── template.json           # Template configuration
├── src/
│   └── App/                    # Console application template
│       ├── App.csproj
│       └── Program.cs
├── tests/
│   └── App.Tests/              # Test project template
│       ├── App.Tests.csproj
│       ├── UnitTest1.cs
│       └── xunit.runner.json
├── ProjectName.sln             # Solution file template
├── console-with-tests.csproj  # NuGet package project
└── README.md                   # Documentation
```

### Testing Your Changes

1. **Unit Tests**: Ensure all existing tests pass
2. **Template Generation**: Test that the template generates correctly
3. **Cross-platform**: Test on Windows, Linux, and macOS if possible
4. **Framework Targets**: Test with different .NET versions (8.0, 9.0)

### Commit Guidelines

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

Example:
```
Add support for .NET 10 framework

- Update template.json to include net10.0 option
- Update project files to support net10.0
- Add tests for new framework target

Fixes #123
```

### Code Style

* Follow C# coding conventions
* Use the provided `.editorconfig` file
* Run code formatting before committing:
  ```bash
  dotnet format
  ```

## Release Process

1. Update version in `ConsoleWithTests.Template.csproj`
2. Update CHANGELOG.md
3. Create a pull request with the changes
4. After merge, create a GitHub release with tag `v{VERSION}`
5. CI/CD will automatically publish to NuGet

## Testing Checklist

Before submitting a PR, ensure:

- [ ] The template builds successfully (`dotnet pack`)
- [ ] Generated projects build without errors
- [ ] Generated tests pass
- [ ] Documentation is updated if needed
- [ ] Code follows the style guidelines
- [ ] Commit messages follow the guidelines
- [ ] All CI checks pass

## Questions?

Feel free to open an issue with your question or reach out to the maintainers.

## Recognition

Contributors will be recognized in:
* The project's README
* Release notes
* GitHub contributors page

Thank you for contributing! 🎉
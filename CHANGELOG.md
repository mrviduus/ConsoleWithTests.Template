# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Future features and improvements will be listed here

## [1.0.0] - 2024-01-01

### Added
- Initial release of ConsoleWithTests.Template
- Console application template with Program.cs and sample Add method
- xUnit v3 test project template with comprehensive test examples
- Solution file template that properly links both projects
- Support for .NET 10, .NET 9, and .NET 8 frameworks
- xunit.runner.json configuration for test execution
- Comprehensive documentation (README, CONTRIBUTING, CODE_OF_CONDUCT, SECURITY)
- GitHub Actions CI/CD pipeline for automated testing and publishing
- Cross-platform validation scripts (bash and PowerShell)
- EditorConfig for consistent code formatting
- Professional NuGet package metadata
- MIT license for open-source usage

### Features
- Clean solution structure with src/ and tests/ folders
- Best practices for .NET development
- Nullable reference types enabled by default
- Implicit usings for cleaner code
- Theory and Fact test examples
- Project reference from test to main project
- Comprehensive .gitignore file

### Developer Experience
- Simple installation via `dotnet new install`
- Intuitive usage with `dotnet new console-with-tests`
- Framework selection parameter
- Automatic NuGet restore post-action
- Detailed contributing guidelines
- Security policy for vulnerability reporting

## Version History

| Version | Release Date | .NET Support | Notable Changes |
|---------|--------------|--------------|-----------------|
| 1.0.0   | 2024-01-01   | 8, 9, 10     | Initial release |

## Upgrade Guide

### From Pre-release to 1.0.0
If you were using a pre-release version, uninstall it first:
```bash
dotnet new uninstall ConsoleWithTests.Template
dotnet new install ConsoleWithTests.Template::1.0.0
```

[Unreleased]: https://github.com/mrviduus/ConsoleWithTests.Template/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/mrviduus/ConsoleWithTests.Template/releases/tag/v1.0.0
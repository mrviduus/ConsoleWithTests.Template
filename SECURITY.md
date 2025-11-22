# Security Policy

## Supported Versions

We release patches for security vulnerabilities. Currently supported versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

We take the security of ConsoleWithTests.Template seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### How to Report a Security Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via email to [INSERT SECURITY EMAIL].

You should receive a response within 48 hours. If for some reason you do not, please follow up via email to ensure we received your original message.

Please include the following information (as much as you can provide) to help us better understand the nature and scope of the possible issue:

* Type of issue (e.g. buffer overflow, SQL injection, cross-site scripting, etc.)
* Full paths of source file(s) related to the manifestation of the issue
* The location of the affected source code (tag/branch/commit or direct URL)
* Any special configuration required to reproduce the issue
* Step-by-step instructions to reproduce the issue
* Proof-of-concept or exploit code (if possible)
* Impact of the issue, including how an attacker might exploit the issue

This information will help us triage your report more quickly.

### Preferred Languages

We prefer all communications to be in English.

### Disclosure Policy

When we receive a security bug report, we will:

1. Confirm the problem and determine the affected versions
2. Audit code to find any potential similar problems
3. Prepare fixes for all supported releases
4. Release new versions of all affected packages

## Security Best Practices for Template Users

When using this template, please follow these security best practices:

### Dependencies

* Regularly update NuGet packages to their latest versions
* Use `dotnet list package --vulnerable` to check for known vulnerabilities
* Review security advisories for dependencies

### Code Security

* Never commit sensitive information (API keys, passwords, connection strings)
* Use secure configuration management (Azure Key Vault, environment variables)
* Enable HTTPS in production environments
* Implement proper authentication and authorization
* Validate all user inputs
* Use parameterized queries to prevent SQL injection
* Implement proper error handling without exposing sensitive information

### Development Practices

* Enable all compiler warnings
* Use static code analysis tools
* Perform regular security audits
* Keep development dependencies up to date
* Use secure communication channels for sensitive discussions

## Security Features in the Template

This template includes several security-oriented features:

* **Nullable Reference Types**: Enabled by default to prevent null reference exceptions
* **Latest Framework**: Targets modern .NET versions with security updates
* **Secure Defaults**: Conservative configuration choices
* **Test Coverage**: Comprehensive test project setup for security testing

## Resources

* [.NET Security Best Practices](https://docs.microsoft.com/en-us/dotnet/standard/security/)
* [OWASP Top 10](https://owasp.org/www-project-top-ten/)
* [CWE/SANS Top 25](https://www.sans.org/top25-software-errors/)
* [NuGet Security](https://docs.microsoft.com/en-us/nuget/consume-packages/finding-and-choosing-packages#package-vulnerability-warnings)

## Comments on this Policy

If you have suggestions on how this process could be improved, please submit a pull request.

## Acknowledgments

We appreciate the security research community's efforts in helping keep our users safe. Responsible disclosure of vulnerabilities helps us ensure the security and privacy of all our users.

### Hall of Fame

We would like to thank the following individuals for responsibly disclosing vulnerabilities:

* _Your name could be here_

---

**Remember**: Security is everyone's responsibility. If you see something, say something!
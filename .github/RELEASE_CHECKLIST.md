# Release Checklist

This checklist should be followed when preparing a new release of ConsoleWithTests.Template.

## Pre-Release

### Code Quality
- [ ] All tests pass locally
- [ ] No compiler warnings
- [ ] Code follows established patterns and conventions
- [ ] Documentation is up to date
- [ ] CHANGELOG.md is updated with new version information

### Validation
- [ ] Run validation script on Windows
  ```powershell
  ./scripts/validate-template.ps1
  ```
- [ ] Run validation script on Linux/Mac
  ```bash
  ./scripts/validate-template.sh
  ```
- [ ] Test template with all supported frameworks (net8.0, net9.0, net10.0)
- [ ] Verify generated projects build successfully
- [ ] Verify generated tests pass
- [ ] Check template works with `dotnet new` command

### Package Metadata
- [ ] Version number updated in `ConsoleWithTests.Template.csproj`
- [ ] Package release notes updated in .csproj
- [ ] Copyright year is current
- [ ] All URLs are correct (repository, project, etc.)
- [ ] License information is accurate

### Documentation Review
- [ ] README.md badges will show correct information
- [ ] Installation instructions are accurate
- [ ] Usage examples work as documented
- [ ] Contributing guidelines are current
- [ ] Security policy contact information is valid

## Release Process

### 1. Create Release Branch
```bash
git checkout -b release/v1.0.0
```

### 2. Update Version
- [ ] Update version in `ConsoleWithTests.Template.csproj`
- [ ] Update version in CHANGELOG.md
- [ ] Update any version references in documentation

### 3. Final Testing
- [ ] Run full CI/CD pipeline
- [ ] Verify all GitHub Actions pass
- [ ] Test installation from local package

### 4. Create Pull Request
- [ ] Create PR from release branch to main
- [ ] Request review from at least one maintainer
- [ ] Ensure all CI checks pass
- [ ] Merge PR

### 5. Tag and Release
```bash
git checkout main
git pull origin main
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

### 6. GitHub Release
- [ ] Go to GitHub Releases page
- [ ] Click "Create Release"
- [ ] Select the version tag
- [ ] Title: "ConsoleWithTests.Template v1.0.0"
- [ ] Copy release notes from CHANGELOG.md
- [ ] Attach the .nupkg file as a binary
- [ ] Publish release

### 7. NuGet Publishing
The CI/CD pipeline will automatically publish to NuGet when a tag is pushed.
If manual publishing is needed:

```bash
dotnet nuget push ./nupkg/ConsoleWithTests.Template.1.0.0.nupkg \
  --source https://api.nuget.org/v3/index.json \
  --api-key YOUR_API_KEY
```

## Post-Release

### Verification
- [ ] Check package appears on NuGet.org
- [ ] Test installation from NuGet:
  ```bash
  dotnet new install ConsoleWithTests.Template::1.0.0
  ```
- [ ] Verify GitHub Release is visible
- [ ] Check CI/CD badge is green

### Communication
- [ ] Tweet about the release (if applicable)
- [ ] Update any blog posts or documentation sites
- [ ] Respond to any immediate issues or questions

### Monitoring
- [ ] Monitor GitHub Issues for problems
- [ ] Check NuGet package statistics
- [ ] Review any automated security alerts

## Rollback Procedure

If a critical issue is found:

1. **Unlist from NuGet** (if possible):
   - Log into NuGet.org
   - Navigate to package
   - Unlist the affected version

2. **Create Hotfix**:
   ```bash
   git checkout -b hotfix/v1.0.1
   # Make fixes
   git commit -m "Fix: critical issue description"
   ```

3. **Fast-track Release**:
   - Follow abbreviated release process
   - Ensure fix is thoroughly tested
   - Communicate about the issue and fix

## Notes

- Always follow semantic versioning (MAJOR.MINOR.PATCH)
- Never force push to main branch
- Keep release notes user-friendly and comprehensive
- Test on multiple platforms before release
- Consider time zones when releasing (avoid Fridays/weekends)
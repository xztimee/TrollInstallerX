# GitHub Actions Workflows

This directory contains GitHub Actions workflows for automating the build and release process of LuiseInstallerX.

## Workflows

### Build and Release (`build-release.yml`)

Automatically builds LuiseInstallerX IPA when code is pushed or tagged.

**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch
- Git tags starting with `v*` (e.g., `v1.0.0`)
- Manual workflow dispatch

**What it does:**
1. Checks out the repository with submodules
2. Sets up Xcode 15.4 on macOS 14
3. Installs ldid for code signing
4. Builds LuiseInstallerX using xcodebuild
5. Creates IPA package
6. Signs with ldid using entitlements
7. Uploads IPA as artifact (available for 30 days)
8. Creates GitHub Release (only for tags)

**Artifacts:**
- `LuiseInstallerX-{commit-sha}.ipa` - Available in Actions tab for 30 days

**Releases:**
When you push a tag (e.g., `v1.0.0`), the workflow will:
- Create a GitHub Release
- Upload the IPA file
- Generate release notes
- Mark as prerelease if tag contains `-beta`, `-rc`, or `-alpha`

## Usage

### Manual Build

To manually trigger a build:
1. Go to Actions tab
2. Select "Build LuiseInstallerX" workflow
3. Click "Run workflow"
4. Select branch
5. Click "Run workflow" button

### Creating a Release

To create a new release:

```bash
# Tag the current commit
git tag v1.0.0

# Push the tag
git push origin v1.0.0
```

The workflow will automatically:
- Build the IPA
- Create a GitHub Release
- Upload the IPA to the release

### Version Naming

Use semantic versioning:
- `v1.0.0` - Stable release
- `v1.0.0-beta.1` - Beta release (marked as prerelease)
- `v1.0.0-rc.1` - Release candidate (marked as prerelease)
- `v1.0.0-alpha.1` - Alpha release (marked as prerelease)

## Build Environment

- **OS:** macOS 14 (Sonoma)
- **Xcode:** 15.4
- **Runner:** GitHub-hosted `macos-14`

## Dependencies

The workflow automatically installs:
- ldid (via Homebrew) - For code signing

## Troubleshooting

### Build Fails

If the build fails:
1. Check the Actions log for errors
2. Verify Xcode project builds locally
3. Ensure all submodules are properly initialized
4. Check that entitlements file exists at `Resources/ents.plist`

### ldid Signing Fails

If ldid signing fails:
1. Verify `Resources/ents.plist` exists and is valid
2. Check ldid installation in workflow log
3. Ensure app bundle is properly built before signing

### Release Not Created

If release is not created for a tag:
1. Verify tag starts with `v` (e.g., `v1.0.0`)
2. Check workflow permissions (needs write access to releases)
3. Review workflow log for errors

## Workflow Configuration

### Modifying Build Settings

To change build configuration, edit `build-release.yml`:

```yaml
xcodebuild -configuration Release \
  -derivedDataPath DerivedData/LuiseInstallerX \
  -destination 'generic/platform=iOS' \
  -scheme LuiseInstallerX \
  CODE_SIGNING_ALLOWED="NO" \
  CODE_SIGNING_REQUIRED="NO" \
  CODE_SIGN_IDENTITY=""
```

### Changing Xcode Version

To use a different Xcode version:

```yaml
- name: Setup Xcode
  uses: maxim-lobanov/setup-xcode@v1
  with:
    xcode-version: '15.4'  # Change this
```

### Artifact Retention

To change how long artifacts are kept:

```yaml
- name: Upload IPA artifact
  uses: actions/upload-artifact@v4
  with:
    retention-days: 30  # Change this (1-90 days)
```

## Security

- No code signing certificates are used (unsigned build)
- ldid is used for fake signing with entitlements
- No secrets or credentials are required
- All builds are reproducible

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Xcode Build Settings](https://developer.apple.com/documentation/xcode/build-settings-reference)
- [ldid Documentation](https://github.com/ProcursusTeam/ldid)
- [LuiseInstallerX Repository](https://github.com/xztimee/LuiseInstallerX)
- [Original TrollInstallerX](https://github.com/alfiecg24/TrollInstallerX)

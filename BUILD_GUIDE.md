# LuiseInstallerX Build Guide

Complete guide for building and releasing LuiseInstallerX.

## Prerequisites

### Local Build
- macOS 12.0 or later
- Xcode 14.0 or later
- ldid (install via Homebrew: `brew install ldid`)

### GitHub Actions Build
- GitHub repository with Actions enabled
- No additional setup required (runs automatically)

## Building Locally

### Quick Build

```bash
# Clone the repository
git clone https://github.com/xztimee/LuiseInstallerX
cd LuiseInstallerX

# Run the build script
./build.sh
```

The IPA will be created at `LuiseInstallerX.ipa`

### Manual Build

```bash
# Build with xcodebuild
xcodebuild -configuration Release \
  -derivedDataPath DerivedData/LuiseInstallerX \
  -destination 'generic/platform=iOS' \
  -scheme LuiseInstallerX \
  CODE_SIGNING_ALLOWED="NO" \
  CODE_SIGNING_REQUIRED="NO" \
  CODE_SIGN_IDENTITY=""

# Create IPA
cd DerivedData/LuiseInstallerX/Build/Products/Release-iphoneos
mkdir Payload
cp -r LuiseInstallerX.app Payload

# Sign with ldid
ldid -S../../../../../Resources/ents.plist Payload/LuiseInstallerX.app

# Create IPA archive
zip -qry LuiseInstallerX.ipa Payload
```

### Build with Xcode GUI

1. Open `LuiseInstallerX.xcodeproj` in Xcode
2. Select "Any iOS Device" as destination
3. Product → Archive
4. Export as IPA (without signing)
5. Sign with ldid: `ldid -SResources/ents.plist LuiseInstallerX.app`

## GitHub Actions Build

### Automatic Builds

Builds trigger automatically on:
- Push to `main` branch
- Pull requests to `main`
- Creating a tag (e.g., `v1.0.0`)

### Manual Build

1. Go to repository on GitHub
2. Click "Actions" tab
3. Select "Build LuiseInstallerX" workflow
4. Click "Run workflow"
5. Select branch and click "Run workflow"

### Download Build Artifacts

1. Go to Actions tab
2. Click on the workflow run
3. Scroll to "Artifacts" section
4. Download `LuiseInstallerX-{commit-sha}.ipa`

Artifacts are kept for 30 days.

## Creating a Release

### Step 1: Prepare Release

1. Update version in project if needed
2. Update CHANGELOG or release notes
3. Commit all changes
4. Push to main branch

### Step 2: Create and Push Tag

```bash
# Create tag
git tag v1.0.0

# Push tag to trigger release
git push origin v1.0.0
```

### Step 3: Verify Release

1. Go to repository on GitHub
2. Check Actions tab - workflow should be running
3. Wait for workflow to complete
4. Go to Releases tab
5. New release should be created with IPA attached

### Version Naming Convention

Use semantic versioning:

- **Stable Release:** `v1.0.0`, `v1.1.0`, `v2.0.0`
- **Beta Release:** `v1.0.0-beta.1`, `v1.0.0-beta.2`
- **Release Candidate:** `v1.0.0-rc.1`, `v1.0.0-rc.2`
- **Alpha Release:** `v1.0.0-alpha.1`

Beta, RC, and Alpha releases are automatically marked as "prerelease" on GitHub.

## Build Output

### Files Created

```
LuiseInstallerX.ipa          # Final IPA package
DerivedData/                 # Build artifacts (can be deleted)
  └── LuiseInstallerX/
      └── Build/
          └── Products/
              └── Release-iphoneos/
                  ├── LuiseInstallerX.app
                  ├── LuiseInstallerX.ipa
                  └── ents.plist
```

### IPA Structure

```
LuiseInstallerX.ipa
└── Payload/
    └── LuiseInstallerX.app/
        ├── LuiseInstallerX (executable)
        ├── Info.plist
        ├── Assets.car
        ├── Frameworks/
        ├── External/
        └── Resources/
```

## Troubleshooting

### Build Fails: "Scheme not found"

**Problem:** Xcode can't find the LuiseInstallerX scheme

**Solution:**
```bash
# List available schemes
xcodebuild -list

# If scheme is missing, open project in Xcode and ensure scheme is shared:
# Product → Scheme → Manage Schemes → Check "Shared"
```

### Build Fails: "ldid: command not found"

**Problem:** ldid is not installed

**Solution:**
```bash
brew install ldid
```

### Build Fails: "No such file or directory: ents.plist"

**Problem:** Entitlements file is missing

**Solution:**
Ensure `Resources/ents.plist` exists with content:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>application-identifier</key>
    <string>LUISELUISE.com.luisepog.luiseinstallerx</string>
    <key>com.apple.developer.team-identifier</key>
    <string>LUISELUISE</string>
    <key>get-task-allow</key>
    <true/>
</dict>
</plist>
```

### IPA Won't Install: "Unable to Install"

**Problem:** IPA is not properly signed

**Solution:**
```bash
# Re-sign the IPA
unzip LuiseInstallerX.ipa
ldid -SResources/ents.plist Payload/LuiseInstallerX.app
zip -qry LuiseInstallerX-signed.ipa Payload
```

### GitHub Actions Fails: "xcodebuild: error"

**Problem:** Build configuration issue

**Solution:**
1. Check Actions log for specific error
2. Verify project builds locally
3. Ensure all submodules are committed
4. Check Xcode version compatibility

## Advanced Configuration

### Custom Build Configuration

Edit `build.sh` or workflow to change:

```bash
# Change build configuration
-configuration Release  # or Debug

# Change architecture
-destination 'generic/platform=iOS'  # All architectures
-arch arm64             # Specific architecture

# Add build flags
OTHER_CFLAGS="-DDEBUG=1"
```

### Custom Entitlements

Edit `Resources/ents.plist` to add/modify entitlements:

```xml
<key>com.apple.security.application-groups</key>
<array>
    <string>group.com.luisepog.luiseinstallerx</string>
</array>
```

### Workflow Customization

Edit `.github/workflows/build-release.yml`:

```yaml
# Change Xcode version
xcode-version: '15.4'

# Change macOS runner
runs-on: macos-14

# Change artifact retention
retention-days: 30
```

## Testing

### Test Build Locally

```bash
# Build
./build.sh

# Verify IPA structure
unzip -l LuiseInstallerX.ipa

# Check signing
ldid -e Payload/LuiseInstallerX.app/LuiseInstallerX
```

### Test on Device

1. Sideload IPA using AltStore, Sideloadly, or similar
2. Open app and verify it launches
3. Test TrollStore installation
4. Check logs for errors

## Resources

- [Xcode Build Settings Reference](https://developer.apple.com/documentation/xcode/build-settings-reference)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [ldid Documentation](https://github.com/ProcursusTeam/ldid)
- [Original TrollInstallerX](https://github.com/alfiecg24/TrollInstallerX)

## Support

For build issues:
- Check [Issues](https://github.com/xztimee/LuiseInstallerX/issues)
- Review [Workflow Logs](https://github.com/xztimee/LuiseInstallerX/actions)
- See [CREDITS.md](CREDITS.md) for original developers

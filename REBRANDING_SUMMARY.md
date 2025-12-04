# LuiseInstallerX Rebranding Summary

This document summarizes all changes made during the rebranding from TrollInstallerX to LuiseInstallerX.

## Completed Changes

### 1. Project Names
- ✅ `TrollInstallerX` → `LuiseInstallerX` (all occurrences)
- ✅ `trollinstallerx` → `luiseinstallerx` (lowercase)
- ✅ `TrollInstallerXApp` → `LuiseInstallerXApp`

### 2. Bundle Identifiers
- ✅ `com.Alfie.TrollInstallerX` → `com.luisepog.luiseinstallerx`
- ✅ `TROLLTROLL` → `LUISELUISE` (team identifier)

### 3. Directory Structure
- ✅ `TrollInstallerX/` → `LuiseInstallerX/`
- ✅ `TrollInstallerX.xcodeproj/` → `LuiseInstallerX.xcodeproj/`

### 4. File Names
- ✅ `TrollInstallerXApp.swift` → `LuiseInstallerXApp.swift`
- ✅ `TrollInstallerX-Bridging-Header.h` → `LuiseInstallerX-Bridging-Header.h`

### 5. URLs and References
- ✅ Updated GitHub repository URLs to `xztimee/LuiseInstallerX`
- ✅ Updated release URLs
- ✅ Kept original TrollInstallerX references in credits

### 6. Documentation
- ✅ README.md updated with fork information
- ✅ CREDITS.md created with full attribution
- ✅ REBRANDING_SUMMARY.md created

### 7. Build Configuration
- ✅ Xcode project file updated
- ✅ Xcode schemes updated
- ✅ Entitlements updated
- ✅ Build script updated

## Files with Intentional TrollStore References

These files keep TrollStore references for compatibility and credits:

1. **CREDITS.md** - Full credits to original developers
2. **README.md** - Credits section and original repository links
3. **LuiseInstallerX/Resources/TrollStore.tar** - The actual TrollStore package (unchanged)

## Automated Rebrand Script

The rebrand was performed using `rebrand_to_luise.sh` which:
- Replaced all text occurrences
- Renamed directories and files
- Updated Xcode project configuration
- Preserved git history

## Repository Information

- **Original Repository:** https://github.com/alfiecg24/TrollInstallerX
- **Fork Repository:** https://github.com/xztimee/LuiseInstallerX
- **Original Author:** alfiecg24
- **Fork Maintainer:** xztimee

## Building

To build LuiseInstallerX:

```bash
# Using the build script
./build.sh

# Or using Xcode
open LuiseInstallerX.xcodeproj
```

The build script will:
1. Build the project using xcodebuild
2. Sign with entitlements
3. Create IPA package
4. Output: `LuiseInstallerX.ipa`

## Testing Checklist

- [ ] Build completes successfully
- [ ] IPA is created correctly
- [ ] App installs on device
- [ ] App launches with LuiseInstallerX branding
- [ ] TrollStore installation works
- [ ] Persistence helper installation works
- [ ] All exploits function correctly

## Version Information

- **Original TrollInstallerX:** Based on latest version from alfiecg24
- **LuiseInstallerX Version:** 1.0.0 (initial fork)
- **iOS Support:** 14.0 - 16.6.1 (arm64 and arm64e)

## Migration Notes

### For Users
- LuiseInstallerX is fully compatible with TrollInstallerX
- Same functionality and features
- Same exploit support
- Same iOS version support

### For Developers
- Fork maintains all original functionality
- Xcode project structure preserved
- Build process unchanged
- All dependencies included

## Contact

For issues specific to LuiseInstallerX:
- Issue Tracker: https://github.com/xztimee/LuiseInstallerX/issues

For issues with the original TrollInstallerX:
- Original Repository: https://github.com/alfiecg24/TrollInstallerX/issues

## Credits

See [CREDITS.md](CREDITS.md) for complete credits and acknowledgments.

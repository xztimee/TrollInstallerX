#!/bin/bash

# Rebrand LuiseInstallerX to LuiseInstallerX
# This script will rename all occurrences of LuiseInstallerX to LuiseInstallerX

set -e

echo "🔄 Starting rebrand process..."

# Step 1: Replace text in all files
echo "📝 Replacing text in files..."

# Replace LuiseInstallerX with LuiseInstallerX (case sensitive)
find . -type f \( -name "*.swift" -o -name "*.m" -o -name "*.h" -o -name "*.plist" -o -name "*.pbxproj" -o -name "*.xcscheme" -o -name "*.sh" -o -name "*.md" \) -exec sed -i 's/LuiseInstallerX/LuiseInstallerX/g' {} +

# Replace luiseinstallerx with luiseinstallerx (lowercase)
find . -type f \( -name "*.swift" -o -name "*.m" -o -name "*.h" -o -name "*.plist" -o -name "*.pbxproj" -o -name "*.xcscheme" -o -name "*.sh" -o -name "*.md" \) -exec sed -i 's/luiseinstallerx/luiseinstallerx/g' {} +

# Replace bundle identifier
find . -type f \( -name "*.plist" -o -name "*.pbxproj" \) -exec sed -i 's/com\.Alfie\.LuiseInstallerX/com.luisepog.luiseinstallerx/g' {} +

# Replace TROLLTROLL with LUISELUISE (team identifier)
find . -type f \( -name "*.plist" -o -name "*.pbxproj" \) -exec sed -i 's/TROLLTROLL/LUISELUISE/g' {} +

# Step 2: Rename directories
echo "📁 Renaming directories..."

if [ -d "LuiseInstallerX" ]; then
    mv LuiseInstallerX LuiseInstallerX
    echo "✅ Renamed LuiseInstallerX/ to LuiseInstallerX/"
fi

if [ -d "LuiseInstallerX.xcodeproj" ]; then
    mv LuiseInstallerX.xcodeproj LuiseInstallerX.xcodeproj
    echo "✅ Renamed LuiseInstallerX.xcodeproj/ to LuiseInstallerX.xcodeproj/"
fi

# Step 3: Rename files
echo "📄 Renaming files..."

# Rename Swift files
if [ -f "LuiseInstallerX/LuiseInstallerXApp.swift" ]; then
    mv LuiseInstallerX/LuiseInstallerXApp.swift LuiseInstallerX/LuiseInstallerXApp.swift
    echo "✅ Renamed LuiseInstallerXApp.swift to LuiseInstallerXApp.swift"
fi

# Rename bridging header
if [ -f "LuiseInstallerX/LuiseInstallerX-Bridging-Header.h" ]; then
    mv LuiseInstallerX/LuiseInstallerX-Bridging-Header.h LuiseInstallerX/LuiseInstallerX-Bridging-Header.h
    echo "✅ Renamed bridging header"
fi

# Step 4: Update references in renamed files
echo "🔧 Updating references in renamed files..."
find . -type f \( -name "*.swift" -o -name "*.m" -o -name "*.h" -o -name "*.plist" -o -name "*.pbxproj" -o -name "*.xcscheme" \) -exec sed -i 's/LuiseInstallerXApp/LuiseInstallerXApp/g' {} +

echo "✅ Rebrand complete!"
echo ""
echo "📋 Summary:"
echo "  - LuiseInstallerX → LuiseInstallerX"
echo "  - com.Alfie.LuiseInstallerX → com.luisepog.luiseinstallerx"
echo "  - TROLLTROLL → LUISELUISE"
echo ""
echo "⚠️  Next steps:"
echo "  1. Review changes with: git diff"
echo "  2. Test build with: ./build.sh"
echo "  3. Commit changes: git add -A && git commit -m 'Rebrand to LuiseInstallerX'"
echo "  4. Push to GitHub: git push origin main"

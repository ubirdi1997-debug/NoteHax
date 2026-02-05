#!/bin/bash

# NoteHax - Build Script for Android Release
# This script automates the build process for the NoteHax Flutter application

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Header
echo "=================================="
echo "  NoteHax - Android Build Script  "
echo "=================================="
echo ""

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    print_error "pubspec.yaml not found. Please run this script from the project root directory."
    exit 1
fi

print_success "Found pubspec.yaml - We're in the right directory"

# Check Flutter installation
print_status "Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    echo ""
    echo "Please install Flutter from: https://flutter.dev/docs/get-started/install"
    echo "After installation, make sure to add Flutter to your PATH"
    exit 1
fi

print_success "Flutter is installed"
flutter --version

# Check Android SDK
print_status "Checking Android SDK..."
if [ -z "$ANDROID_HOME" ] && [ -z "$ANDROID_SDK_ROOT" ]; then
    print_warning "ANDROID_HOME or ANDROID_SDK_ROOT not set"
    
    # Check if local.properties exists
    if [ ! -f "android/local.properties" ]; then
        print_error "android/local.properties not found"
        echo ""
        echo "Please create android/local.properties with:"
        echo "sdk.dir=/path/to/android/sdk"
        echo "flutter.sdk=/path/to/flutter"
        exit 1
    else
        print_success "Found android/local.properties"
    fi
else
    print_success "Android SDK found at: ${ANDROID_HOME:-$ANDROID_SDK_ROOT}"
fi

# Check Java
print_status "Checking Java installation..."
if ! command -v java &> /dev/null; then
    print_error "Java is not installed or not in PATH"
    echo ""
    echo "Please install Java JDK 11 or higher"
    exit 1
fi

print_success "Java is installed"
java -version 2>&1 | head -1

# Check signing key
print_status "Checking signing configuration..."
if [ ! -f "android/key.jks" ]; then
    print_error "Signing key android/key.jks not found"
    exit 1
fi

if [ ! -f "android/key.properties" ]; then
    print_error "Key properties android/key.properties not found"
    exit 1
fi

print_success "Signing configuration found"

# Ask user what to build
echo ""
echo "What would you like to build?"
echo "1) Release APK (for testing/sideloading)"
echo "2) Release App Bundle - AAB (for Play Store)"
echo "3) Split APKs (smaller size, per architecture)"
echo "4) All of the above"
echo "5) Just clean and get dependencies"
echo ""
read -p "Enter your choice (1-5): " choice

# Clean previous builds
print_status "Cleaning previous builds..."
flutter clean
print_success "Clean complete"

# Get dependencies
print_status "Getting dependencies..."
flutter pub get
print_success "Dependencies fetched"

# Check if we need to run build_runner
if grep -q "build_runner" pubspec.yaml; then
    print_status "Running code generation (Hive adapters)..."
    flutter pub run build_runner build --delete-conflicting-outputs
    print_success "Code generation complete"
fi

# Build based on user choice
case $choice in
    1)
        print_status "Building release APK..."
        flutter build apk --release
        print_success "APK build complete!"
        echo ""
        echo "Output: build/app/outputs/flutter-apk/app-release.apk"
        ;;
    2)
        print_status "Building release App Bundle (AAB)..."
        flutter build appbundle --release
        print_success "App Bundle build complete!"
        echo ""
        echo "Output: build/app/outputs/bundle/release/app-release.aab"
        ;;
    3)
        print_status "Building split APKs..."
        flutter build apk --release --split-per-abi
        print_success "Split APKs build complete!"
        echo ""
        echo "Outputs:"
        echo "  - build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk"
        echo "  - build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
        echo "  - build/app/outputs/flutter-apk/app-x86_64-release.apk"
        ;;
    4)
        print_status "Building all variants..."
        
        print_status "1/3: Building release APK..."
        flutter build apk --release
        
        print_status "2/3: Building release App Bundle (AAB)..."
        flutter build appbundle --release
        
        print_status "3/3: Building split APKs..."
        flutter build apk --release --split-per-abi
        
        print_success "All builds complete!"
        echo ""
        echo "Outputs:"
        echo "  APK:  build/app/outputs/flutter-apk/app-release.apk"
        echo "  AAB:  build/app/outputs/bundle/release/app-release.aab"
        echo "  Split APKs:"
        echo "    - build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk"
        echo "    - build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
        echo "    - build/app/outputs/flutter-apk/app-x86_64-release.apk"
        ;;
    5)
        print_success "Dependencies ready! You can now build manually."
        exit 0
        ;;
    *)
        print_error "Invalid choice"
        exit 1
        ;;
esac

# Verify the build
echo ""
print_status "Build verification..."

if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
    APK_SIZE=$(du -h "build/app/outputs/flutter-apk/app-release.apk" | cut -f1)
    print_success "APK verified - Size: $APK_SIZE"
    
    # Check if jarsigner is available
    if command -v jarsigner &> /dev/null; then
        print_status "Verifying APK signature..."
        if jarsigner -verify build/app/outputs/flutter-apk/app-release.apk &> /dev/null; then
            print_success "APK signature verified!"
        else
            print_warning "Could not verify APK signature"
        fi
    fi
fi

if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
    AAB_SIZE=$(du -h "build/app/outputs/bundle/release/app-release.aab" | cut -f1)
    print_success "AAB verified - Size: $AAB_SIZE"
fi

# Summary
echo ""
echo "=================================="
echo "         Build Complete! 🚀       "
echo "=================================="
echo ""
echo "Next steps:"
echo "1. Test the APK on a physical device:"
echo "   adb install build/app/outputs/flutter-apk/app-release.apk"
echo ""
echo "2. For Play Store submission:"
echo "   - Upload: build/app/outputs/bundle/release/app-release.aab"
echo "   - Follow: play_console_assets/submission_checklist.md"
echo ""
echo "3. For more information, see:"
echo "   - SETUP_COMPLETE.md"
echo "   - BUILD_VERIFICATION.md"
echo ""
print_success "All done!"

# Quick Build Commands Reference

## 🚀 Build Commands (Run Locally)

### Prerequisites
```bash
# Verify Flutter is installed
flutter --version

# Navigate to project
cd /path/to/NoteHax
```

### Get Dependencies
```bash
flutter pub get
```

### Build APK (for Testing)
```bash
flutter build apk --release
```
**Output**: `build/app/outputs/flutter-apk/app-release.apk`

### Build App Bundle (for Play Store)
```bash
flutter build appbundle --release
```
**Output**: `build/app/outputs/bundle/release/app-release.aab`

### Build Split APKs (Smaller Size)
```bash
flutter build apk --release --split-per-abi
```

### Build with Obfuscation (Production)
```bash
flutter build appbundle --release --obfuscate --split-debug-info=build/symbols
```

## ⚙️ Configuration Files

| File | Status | Purpose |
|------|--------|---------|
| `android/key.properties` | ✅ | Signing credentials |
| `android/key.jks` | ✅ | Keystore file |
| `android/app/build.gradle` | ✅ | Build configuration |
| `pubspec.yaml` | ✅ | Dependencies |

## 📍 Output Locations

| Build Type | Output Path | Size |
|------------|-------------|------|
| Universal APK | `build/app/outputs/flutter-apk/app-release.apk` | ~40-80 MB |
| App Bundle | `build/app/outputs/bundle/release/app-release.aab` | ~30-50 MB |
| Split APKs | `build/app/outputs/flutter-apk/app-*-release.apk` | ~20-30 MB each |

## ✅ Verification

```bash
# Verify APK signature
jarsigner -verify -verbose build/app/outputs/flutter-apk/app-release.apk

# Install on device
flutter install --release

# Or use adb
adb install build/app/outputs/flutter-apk/app-release.apk
```

## 📚 Documentation

- **BUILD_EXECUTION_STATUS.md** - Why builds cannot run in CI + full instructions
- **BUILD_VERIFICATION.md** - Verification checklist
- **RELEASE_SETUP_COMPLETE.md** - Complete setup summary
- **play_console_assets/** - Play Console submission guides

## 🐛 Troubleshooting

### Plugin Warnings (file_picker)
**Warning**: `Package file_picker:macos/windows references... as the default plugin`

**Solution**: Safe to ignore. These warnings occur for macOS/Windows platforms we're not building for. Android builds work fine.

### Android SDK Not Found
**Error**: `[!] No Android SDK found. Try setting the ANDROID_HOME`

**Solution**: Set ANDROID_HOME or create `android/local.properties`:
```bash
# Set environment variable (Linux/macOS)
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Or create android/local.properties
echo "sdk.dir=/path/to/android/sdk" > android/local.properties
# Example: sdk.dir=/Users/username/Android/Sdk
```

### Gradle Error
```bash
cd android && ./gradlew clean && cd ..
flutter clean
flutter pub get
```

### SDK Not Found
Create `android/local.properties`:
```properties
sdk.dir=/path/to/android/sdk
flutter.sdk=/path/to/flutter
```

### Out of Memory
Add to `android/gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx4096m
```

## 📦 Next Steps

1. Build locally using commands above
2. Test APK on device
3. Upload AAB to Play Console
4. Follow `play_console_assets/submission_checklist.md`

---

**App**: NoteHax v1.0.0+1  
**Package**: com.notehax.usafe  
**Company**: BYRON AGRO INDIA PRIVATE LIMITED


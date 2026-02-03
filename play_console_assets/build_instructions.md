# Build Instructions - APK and AAB Generation

## Prerequisites

1. **Flutter SDK** installed and configured
2. **Android SDK** installed
3. **Java JDK** installed (Java 11 or higher recommended)
4. **Signing key configured** (key.jks and key.properties already set up)

## Quick Build Commands

### 1. Build Release APK (For Testing)

```bash
cd /home/runner/work/NoteHax/NoteHax
flutter build apk --release
```

**Output Location**: `build/app/outputs/flutter-apk/app-release.apk`

**File Size**: Typically 40-80 MB (includes all architectures)

**Use Case**: 
- Testing on physical devices
- Sharing with beta testers
- Internal distribution

---

### 2. Build Split APKs by Architecture (Smaller Size)

```bash
flutter build apk --release --split-per-abi
```

**Output Location**: `build/app/outputs/flutter-apk/`
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM)
- `app-x86_64-release.apk` (64-bit x86)

**File Size**: ~20-30 MB each

**Use Case**:
- Smaller downloads
- Specific device architecture
- Faster installation

---

### 3. Build App Bundle (AAB) - **Required for Play Store**

```bash
flutter build appbundle --release
```

**Output Location**: `build/app/outputs/bundle/release/app-release.aab`

**File Size**: Typically 30-50 MB

**Use Case**: 
- **Google Play Console upload (Required)**
- Automatic optimization for each device
- Smaller downloads for users
- Better user experience

---

## Detailed Build Process

### Step 1: Clean Previous Builds

```bash
cd /home/runner/work/NoteHax/NoteHax
flutter clean
flutter pub get
```

### Step 2: Update Version Number (Optional)

Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1
# Format: major.minor.patch+buildNumber
```

### Step 3: Build Release

#### For APK:
```bash
flutter build apk --release
```

#### For AAB (App Bundle):
```bash
flutter build appbundle --release
```

### Step 4: Verify Build

```bash
# Check APK
ls -lh build/app/outputs/flutter-apk/

# Check AAB
ls -lh build/app/outputs/bundle/release/
```

### Step 5: Test APK Locally

```bash
# Install on connected device
flutter install --release

# Or manually install
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## Advanced Build Options

### 1. Build with Obfuscation (Recommended for Production)

```bash
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info
```

**Benefits**:
- Code obfuscation (harder to reverse engineer)
- Smaller file size
- Better security

**Note**: Save the debug symbols for crash reporting

---

### 2. Build with Specific Target Platform

```bash
# For 64-bit ARM only (most modern devices)
flutter build apk --release --target-platform android-arm64

# For 32-bit ARM (older devices)
flutter build apk --release --target-platform android-arm
```

---

### 3. Build with Custom Build Name

```bash
flutter build appbundle --release --build-name=1.0.1 --build-number=2
```

---

## Build Optimization Tips

### 1. Reduce App Size

```bash
# Enable R8 full mode (in android/gradle.properties)
android.enableR8.fullMode=true

# Build with optimization
flutter build appbundle --release --obfuscate --split-debug-info=build/symbols
```

### 2. Analyze Bundle Size

```bash
# After building
flutter build appbundle --release --analyze-size

# Or manually check
ls -lh build/app/outputs/bundle/release/app-release.aab
```

### 3. Check What's in Your APK

```bash
# Analyze APK composition
flutter build apk --release --analyze-size --target-platform android-arm64
```

---

## Troubleshooting

### Issue: "Keystore was tampered with"
**Solution**: Verify key.properties credentials match key.jks

### Issue: "SDK location not found"
**Solution**: Create `android/local.properties`:
```properties
sdk.dir=/path/to/android/sdk
flutter.sdk=/path/to/flutter
```

### Issue: "Build failed with Gradle error"
**Solution**: 
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build appbundle --release
```

### Issue: "Out of memory during build"
**Solution**: Add to `android/gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx4096m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
```

---

## File Checklist Before Upload

### For Google Play Console Upload:

- [ ] **app-release.aab** file built successfully
- [ ] File size < 150 MB (requirement)
- [ ] Signed with release key (key.jks)
- [ ] Version code incremented from previous release
- [ ] Tested on at least one physical device
- [ ] All required permissions declared in AndroidManifest.xml
- [ ] Privacy policy URL ready
- [ ] Screenshots prepared (min 2, max 8)
- [ ] Store listing text ready
- [ ] Feature graphic (1024x500) ready

### For Beta Testing:

- [ ] **app-release.apk** built
- [ ] Installed and tested on multiple devices
- [ ] All features working as expected
- [ ] No crashes on startup
- [ ] Permissions granted correctly
- [ ] Database migrations work (if applicable)

---

## Build Output Locations

```
NoteHax/
└── build/
    └── app/
        └── outputs/
            ├── flutter-apk/
            │   ├── app-release.apk              # Single APK (all architectures)
            │   ├── app-armeabi-v7a-release.apk  # 32-bit ARM
            │   ├── app-arm64-v8a-release.apk    # 64-bit ARM (most devices)
            │   └── app-x86_64-release.apk       # Intel/AMD
            └── bundle/
                └── release/
                    └── app-release.aab          # App Bundle (for Play Store)
```

---

## Quick Reference

| Build Type | Command | Output | Use Case |
|------------|---------|--------|----------|
| Universal APK | `flutter build apk --release` | app-release.apk | Testing, sideloading |
| Split APKs | `flutter build apk --release --split-per-abi` | Multiple APKs | Smaller size per device |
| App Bundle | `flutter build appbundle --release` | app-release.aab | **Play Store upload** |
| Obfuscated | `flutter build appbundle --release --obfuscate` | app-release.aab | Production release |

---

## Next Steps After Building

1. ✅ **Test the APK** on physical devices
2. ✅ **Upload AAB to Play Console** (Internal Testing track first)
3. ✅ **Submit for review** after internal testing
4. ✅ **Monitor crash reports** via Play Console
5. ✅ **Update version** for next release

---

**Need Help?**
- Flutter Build Documentation: https://flutter.dev/docs/deployment/android
- Play Console Help: https://support.google.com/googleplay/android-developer


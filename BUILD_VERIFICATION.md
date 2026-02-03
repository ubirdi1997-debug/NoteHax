# Build Verification Guide

## Quick Verification Commands

Before submitting to Play Store, verify your configuration:

### 1. Check Icon Files
```bash
find android/app/src/main/res -name "ic_launcher.png" -ls
```
Expected: 5 icon files in different mipmap directories

### 2. Verify Key Configuration
```bash
cat android/key.properties
```
Expected output:
```
storePassword=1234567890
keyPassword=1234567890
keyAlias=key0
storeFile=../key.jks
```

### 3. Check Key File Exists
```bash
ls -lh android/key.jks
```
Expected: File exists (~2.7KB)

### 4. Verify build.gradle Configuration
```bash
grep -A 5 "signingConfigs" android/app/build.gradle
```
Should show release signing configuration

### 5. Test Build APK
```bash
flutter clean
flutter pub get
flutter build apk --release
```
Expected: APK created at `build/app/outputs/flutter-apk/app-release.apk`

### 6. Test Build AAB
```bash
flutter build appbundle --release
```
Expected: AAB created at `build/app/outputs/bundle/release/app-release.aab`

### 7. Verify APK Signature
```bash
# Install on device
flutter install --release

# Or check signature
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk
```

### 8. Check App Info
```bash
aapt dump badging build/app/outputs/flutter-apk/app-release.apk | grep -E "package|label|icon"
```
Expected:
- package: name='com.notehax.usafe'
- application-label:'NoteHax'
- application-icon-160:'res/mipmap-mdpi-v4/ic_launcher.png'

## Common Issues

### Issue: "Keystore was tampered with"
**Solution**: Verify credentials in key.properties match the key.jks

### Issue: "No signing config"
**Solution**: Ensure key.properties exists and is readable

### Issue: "Icon not found"
**Solution**: Verify ic_launcher.png exists in all mipmap directories

## Success Checklist

- [ ] All 5 icon files exist
- [ ] key.properties has correct credentials
- [ ] key.jks file exists
- [ ] build.gradle has signingConfigs section
- [ ] APK builds successfully
- [ ] AAB builds successfully
- [ ] APK is signed (jarsigner verify passes)
- [ ] APK installs and runs on device
- [ ] App icon appears correctly on device

## File Sizes to Expect

- APK (universal): ~40-80 MB
- AAB (app bundle): ~30-50 MB
- Split APKs: ~20-30 MB each

## Ready for Production!

Once all checks pass, you're ready to submit to Google Play Console.

Follow: `play_console_assets/submission_checklist.md`


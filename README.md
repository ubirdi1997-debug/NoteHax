# NoteHax - Smart Hacker Notebook

**Version:** 1.0.0  
**Package:** com.notehax.usafe  
**Developed by:** BYRON AGRO INDIA PRIVATE LIMITED  
**Support:** notehax.aarav@gmail.com

## 🎯 About NoteHax

NoteHax is a modern, fast, offline-first Flutter notes app with a "smart hacker notebook" theme. It combines productivity with clever automation, featuring a sleek, minimal design with dark mode, neon accents, smooth animations, and Material 3 design principles.

## ✨ Features

### 🧠 Smart Notes Engine
- **Auto-detection**: Automatically detects phone numbers, emails, and URLs in your notes
- **Tap-to-Action**: Tap phone numbers to call, emails to compose mail, URLs to open browser
- **Hashtag System**: Use #tags to organize notes automatically
- **Auto-grouping**: Notes automatically group by tags

### ⚡ Quick Hax Panel
Floating action button opens quick access panel with:
- 🎙️ Voice to note (voice-to-text)
- 📷 Scan text from camera (OCR)
- 📋 Paste from clipboard
- ✅ Create checklist

### 🔐 Secure Vault Notes
- Lock notes with PIN or biometric authentication
- Hidden notes folder for sensitive information
- Encrypted data storage

### ⏳ Time Capsule Notes
- Set future "Unlock Date" for notes
- Notes remain hidden until the specified date
- Perfect for future reminders and time-based content

### 🎨 Note Personalization
- Multiple background colors
- Custom font styles
- Full Markdown support
- Add images to notes

### 📌 Smart Reminder Notes
- Attach reminders to specific notes
- Notifications open the exact note
- Never miss important deadlines

### 🔍 Instant Search Engine
- Search inside note content
- Search by tags
- Filter by note type (text/checklist/locked)

### ☁️ Backup System
- Local backup export (JSON format)
- Easy import/restore functionality
- Google Drive ready (future feature)

## 🛠️ Technology Stack

- **Framework**: Flutter (3.0+)
- **State Management**: Riverpod
- **Local Database**: Hive
- **Security**: flutter_secure_storage, local_auth, encrypt
- **Smart Features**: speech_to_text, google_mlkit_text_recognition
- **Architecture**: Clean architecture with null safety

## 📱 Screens

- **Splash Screen**: Beautiful branded launch screen
- **Home Screen**: Grid/List toggle view of all notes
- **Note Editor**: Full-featured editor with smart detection
- **Locked Vault**: Secure area for locked notes
- **Search Screen**: Advanced search and filtering
- **Settings**: App configuration and preferences
- **About Page**: Company information and features

## 🎨 Design Philosophy

- **Dark Theme**: Default dark mode for reduced eye strain
- **Neon Accents**: Electric blue and green highlights
- **Smooth Transitions**: 60fps animations throughout
- **Glassmorphism**: Modern translucent card effects
- **Minimal Icons**: Clean, professional iconography

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode (for mobile development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/ubirdi1997-debug/NoteHax.git
cd NoteHax
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📦 Building for Production

### Quick Build (Recommended)

NoteHax includes automated build scripts for easy release builds:

**Linux/macOS:**
```bash
./build_release.sh
```

**Windows:**
```cmd
build_release.bat
```

These scripts will:
- ✅ Verify Flutter and Android SDK installation
- ✅ Clean previous builds
- ✅ Fetch all dependencies
- ✅ Generate required code (Hive adapters)
- ✅ Build release APK/AAB with signing
- ✅ Verify build outputs

### Manual Build Commands

#### Android APK (for testing/sideloading)
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

#### Android App Bundle (for Play Store - **REQUIRED**)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

#### Split APKs (smaller size per architecture)
```bash
flutter build apk --release --split-per-abi
```

#### With Code Obfuscation (Production Recommended)
```bash
flutter build appbundle --release --obfuscate --split-debug-info=build/symbols
```

### iOS IPA
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 📚 Complete Documentation

For detailed setup and build instructions, see:

- **[SETUP_COMPLETE.md](SETUP_COMPLETE.md)** - Complete setup status and instructions
- **[BUILD_EXECUTION_STATUS.md](BUILD_EXECUTION_STATUS.md)** - Environment setup guide
- **[QUICK_BUILD_REFERENCE.md](QUICK_BUILD_REFERENCE.md)** - Quick command reference
- **[BUILD_VERIFICATION.md](BUILD_VERIFICATION.md)** - Build verification checklist
- **[play_console_assets/](play_console_assets/)** - Play Store submission guides

## 🔐 Release Configuration

NoteHax is **fully configured** for release builds:

✅ **Signing Keys**: Configured in `android/key.jks` and `android/key.properties`  
✅ **App Icons**: All Android density variants (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)  
✅ **Build Configuration**: Release signing enabled in `android/app/build.gradle`  
✅ **Dependencies**: All packages defined and ready in `pubspec.yaml`  
✅ **Play Store Assets**: Complete store listing and submission documentation

**Package Name**: `com.notehax.usafe.notehax`  
**Version**: 1.0.0+1  
**Min SDK**: Android 6.0 (API 23)  
**Target SDK**: Android 14 (API 34)

## 📄 License

This project is developed by BYRON AGRO INDIA PRIVATE LIMITED.

## 📧 Support

For support, email: notehax.aarav@gmail.com

---

**NoteHax** - Where productivity meets clever automation 🚀
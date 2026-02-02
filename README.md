# NoteHax - Smart Hacker Notebook

**Version:** 1.0.0  
**Package:** com.notehax.usafe  
**Developed by:** Geometic Eduservices Private Limited  
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

### Android APK
```bash
flutter build apk --release
```

### iOS IPA
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 📄 License

This project is developed by Geometic Eduservices Private Limited.

## 📧 Support

For support, email: notehax.aarav@gmail.com

---

**NoteHax** - Where productivity meets clever automation 🚀
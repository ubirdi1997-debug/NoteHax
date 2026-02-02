# NoteHax

A simple and elegant notes application built with Flutter.

## Features

- ✨ Create, read, update, and delete notes
- 🎨 Material Design 3 UI with light and dark theme support
- 💾 Local SQLite database storage
- 📱 Works on Android, iOS, and Web
- 🔍 Clean and intuitive interface
- ⚡ Fast and responsive

## Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode (for mobile development)
- A code editor (VS Code, Android Studio, or IntelliJ IDEA)

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/ubirdi1997-debug/NoteHax.git
cd NoteHax
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

For Android/iOS:
```bash
flutter run
```

For Web:
```bash
flutter run -d chrome
```

For a specific device:
```bash
flutter devices  # List available devices
flutter run -d <device-id>
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── note.dart               # Note data model
├── screens/
│   ├── home_screen.dart        # Main screen with notes list
│   └── note_editor_screen.dart # Screen for creating/editing notes
└── services/
    └── database_service.dart   # SQLite database service
```

## Building for Production

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

## Dependencies

- `flutter`: Flutter SDK
- `sqflite`: SQLite database for local storage
- `path_provider`: For accessing device directories
- `shared_preferences`: For storing user preferences
- `intl`: For date formatting
- `cupertino_icons`: iOS-style icons

## Development

### Running Tests
```bash
flutter test
```

### Analyzing Code
```bash
flutter analyze
```

### Formatting Code
```bash
flutter format .
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.
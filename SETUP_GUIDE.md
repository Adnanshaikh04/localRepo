# Flutter Auto Screenshot App - Setup Guide

This guide will help you set up and run the Flutter Auto Screenshot application on your local machine.

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Git** - [Download Git](https://git-scm.com/downloads)
- **Flutter SDK** - [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)
- **Android Studio** (for Android development) - [Download Android Studio](https://developer.android.com/studio)
- **Xcode** (for iOS development, macOS only) - Available on Mac App Store

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/Adnanshaikh04/localRepo.git
cd localRepo
```

### 2. Switch to the Flutter App Branch

```bash
git checkout cursor/take-flutter-screenshots-every-two-minutes-eacf
```

### 3. Navigate to the Flutter Project

```bash
cd screenshot_app
```

### 4. Install Flutter Dependencies

```bash
flutter pub get
```

### 5. Run the Application

```bash
flutter run
```

## 🔧 Detailed Setup Instructions

### Flutter SDK Installation

If you don't have Flutter installed:

#### On Windows:
1. Download Flutter SDK from [flutter.dev](https://docs.flutter.dev/get-started/install/windows)
2. Extract to `C:\flutter`
3. Add `C:\flutter\bin` to your PATH environment variable

#### On macOS:
```bash
# Using Homebrew
brew install flutter

# Or download from flutter.dev and add to PATH
export PATH="$PATH:/path-to-flutter-sdk/flutter/bin"
```

#### On Linux:
```bash
# Download and extract Flutter
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.5-stable.tar.xz
tar xf flutter_linux_3.16.5-stable.tar.xz

# Add to PATH
export PATH="$PATH:$PWD/flutter/bin"
```

### Verify Flutter Installation

```bash
flutter doctor
```

This command checks your environment and displays a report of the status of your Flutter installation.

### Android Setup

1. **Install Android Studio**
2. **Install Android SDK** (usually done automatically with Android Studio)
3. **Accept Android licenses**:
   ```bash
   flutter doctor --android-licenses
   ```
4. **Connect an Android device or start an emulator**

### iOS Setup (macOS only)

1. **Install Xcode** from the Mac App Store
2. **Install Xcode command-line tools**:
   ```bash
   sudo xcode-select --install
   ```
3. **Accept Xcode license**:
   ```bash
   sudo xcodebuild -license accept
   ```

## 📱 Running the App

### On Android Device/Emulator

1. **Connect your Android device** via USB with USB debugging enabled
   - OR start an Android emulator from Android Studio

2. **Check connected devices**:
   ```bash
   flutter devices
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### On iOS Device/Simulator (macOS only)

1. **Open iOS Simulator** or connect an iOS device
2. **Run the app**:
   ```bash
   flutter run
   ```

## 🔐 Permissions

The app requires storage permissions to save screenshots:

### Android
- The app will automatically request storage permissions on first run
- For Android 11+, you may need to manually grant "All files access" permission

### iOS
- The app saves screenshots to the app's documents directory
- No additional permissions required

## 📂 Project Structure

```
screenshot_app/
├── lib/
│   └── main.dart              # Main application code
├── android/                   # Android-specific files
│   └── app/src/main/
│       └── AndroidManifest.xml   # Android permissions
├── ios/                       # iOS-specific files
├── pubspec.yaml              # Dependencies and project config
└── README.md                 # Project documentation
```

## 🐛 Troubleshooting

### Common Issues

1. **"Flutter command not found"**
   - Ensure Flutter is added to your PATH environment variable
   - Restart your terminal/command prompt

2. **"No connected devices"**
   - For Android: Enable USB debugging and connect device
   - For iOS: Open iOS Simulator or connect iOS device

3. **Permission denied errors**
   - Grant storage permissions when prompted
   - Check app settings if permissions were denied

4. **Build errors**
   - Run `flutter clean` and then `flutter pub get`
   - Ensure all dependencies are properly installed

### Getting Help

- **Flutter Documentation**: [docs.flutter.dev](https://docs.flutter.dev)
- **Flutter Community**: [flutter.dev/community](https://flutter.dev/community)
- **Stack Overflow**: Search for Flutter-related questions

## 📝 Development Commands

```bash
# Install dependencies
flutter pub get

# Run the app in debug mode
flutter run

# Run the app in release mode
flutter run --release

# Build APK for Android
flutter build apk

# Build iOS app (macOS only)
flutter build ios

# Run tests
flutter test

# Analyze code
flutter analyze

# Clean build files
flutter clean
```

## 🎯 App Features

- ✅ Automatic screenshots every 2 minutes
- ✅ Manual screenshot capture
- ✅ Screenshot file management
- ✅ Storage permission handling
- ✅ Real-time status updates
- ✅ Modern Material Design UI

## 📄 License

This project is open source. Feel free to use, modify, and distribute as needed.

---

**Happy Coding!** 🚀

If you encounter any issues, please check the troubleshooting section or refer to the Flutter documentation.
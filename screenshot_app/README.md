# Auto Screenshot Flutter App

A Flutter application that automatically takes screenshots every 2 minutes and saves them to device storage.

## Features

- **Automatic Screenshots**: Takes screenshots every 2 minutes when enabled
- **Manual Screenshots**: Take screenshots on demand
- **Storage Management**: Saves screenshots to device storage with timestamps
- **Permission Handling**: Automatically requests necessary storage permissions
- **Real-time Status**: Shows current status and screenshot count
- **File Management**: Lists all captured screenshots with file paths
- **Modern UI**: Clean, Material Design 3 interface

## How to Use

1. **Start Auto Screenshots**: Tap the "Start Auto Screenshots" button to begin automatic screenshot capture every 2 minutes
2. **Stop Auto Screenshots**: Tap the "Stop Auto Screenshots" button to stop the automatic capture
3. **Manual Screenshot**: Use the "Take Manual Screenshot" button to capture a screenshot immediately
4. **Clear Screenshots**: Use the "Clear Screenshots" button to remove all screenshot records from the list
5. **View Screenshot Files**: The app displays a list of all captured screenshots with their file paths

## Screenshots Storage

Screenshots are saved with the following naming convention:
- **Filename**: `screenshot_[timestamp].png`
- **Location**: 
  - Android: External storage directory (if available) or app documents directory
  - iOS: App documents directory

## Permissions

The app requires the following permissions on Android:
- `WRITE_EXTERNAL_STORAGE`: To save screenshots to storage
- `READ_EXTERNAL_STORAGE`: To access storage
- `MANAGE_EXTERNAL_STORAGE`: For Android 11+ storage access

## Technical Details

- **Screenshot Interval**: 2 minutes (120 seconds)
- **File Format**: PNG
- **Timestamp**: Milliseconds since epoch for unique filenames
- **UI Framework**: Flutter with Material Design 3
- **State Management**: StatefulWidget with Timer for periodic execution

## Dependencies

- `screenshot: ^2.1.0` - For capturing screenshots
- `path_provider: ^2.1.1` - For accessing device storage paths
- `permission_handler: ^11.0.1` - For managing storage permissions

## Building and Running

1. Ensure Flutter is installed and configured
2. Run `flutter pub get` to install dependencies
3. Connect a device or start an emulator
4. Run `flutter run` to launch the app

## Notes

- The app captures screenshots of its own interface
- Screenshots include all visible content within the app's screen area
- The timer continues running in the background while the app is active
- Screenshots are automatically stopped when the app is disposed

## Platform Support

- ✅ Android
- ✅ iOS (with appropriate iOS permissions)
- ⚠️ Web (limited screenshot functionality)
- ⚠️ Desktop (may require additional configuration)

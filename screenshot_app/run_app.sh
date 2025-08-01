#!/bin/bash

echo "Auto Screenshot Flutter App"
echo "==========================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    echo "Please install Flutter from https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"
echo ""

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

if [ $? -ne 0 ]; then
    echo "❌ Failed to get dependencies"
    exit 1
fi

echo "✅ Dependencies installed successfully"
echo ""

# Check for connected devices
echo "📱 Checking for connected devices..."
flutter devices

echo ""
echo "🚀 Starting the app..."
echo "Note: Make sure you have a device connected or an emulator running"
echo ""

# Run the app
flutter run
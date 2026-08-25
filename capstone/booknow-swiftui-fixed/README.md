# BookNow (SwiftUI - Fixed)

Capstone project for Section 15 of the iOS Testing course.

## How to run on Simulator

### 1. From Terminal:
```bash
# Generate the Xcode project
xcodegen generate

# Open in Xcode or build and run
open BookNow.xcodeproj
```

### 2. Quick Command Line Build & Run:
```bash
# Build
xcodebuild -project BookNow.xcodeproj -scheme BookNow -destination "platform=iOS Simulator,name=iPhone 17" -derivedDataPath /tmp/BookNowDerivedData build

# Install and Launch
xcrun simctl install booted /tmp/BookNowDerivedData/Build/Products/Debug-iphonesimulator/BookNow.app
xcrun simctl launch booted com.booknow.ios
```

## Demo Credentials
- **Email:** `guest@booknow.com`
- **Password:** `stay2026`

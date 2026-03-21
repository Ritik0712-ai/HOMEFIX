# HomeFix Pro

HomeFix Pro is a Flutter mobile app prototype for a home service subscription platform. The app lets users explore onboarding flows, sign in with mocked auth, purchase a monthly or yearly subscription, request electrician or plumber support, and manage their profile from a clean multi-screen UI.

## Features

- Splash and onboarding experience
- Login and signup flow with mocked authentication
- Subscription purchase flow with monthly and yearly plans
- Home dashboard with subscription-aware service access
- Service request tracking for electricians and plumbers
- Profile screen with subscription status and logout
- Provider-based state management with mock API responses

## Tech Stack

- Flutter
- Dart
- Provider
- Google Fonts
- smooth_page_indicator

## Project Structure

```text
lib/
  app.dart
  core/
  models/
  providers/
  screens/
    auth/
  services/
  widgets/
test/
android/
ios/
linux/
macos/
web/
windows/
```

## Prerequisites

Make sure these are installed before you start:

- Flutter SDK
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Xcode for iOS/macOS builds on macOS

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/th-arya/HOMEFIX.git
   ```

2. Open the project folder:

   ```bash
   cd HOMEFIX
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app on a connected device or emulator:

   ```bash
   flutter run
   ```

## Useful Commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Mocked App Behavior

- Authentication is currently mocked in `lib/services/mock_api_service.dart`
- Subscription purchases are simulated locally
- Service requests move through fake status transitions for demo purposes
- No production backend or payment gateway is connected yet

## Team Workflow

For team collaboration, use a simple branch-based workflow:

1. Pull the latest `main` branch.
2. Create a feature branch:

   ```bash
   git checkout -b feature/your-task-name
   ```

3. Make changes and run checks:

   ```bash
   flutter analyze
   flutter test
   ```

4. Commit with clear messages:

   ```bash
   git commit -m "feat: add subscription renewal flow"
   ```

5. Push your branch and open a pull request:

   ```bash
   git push origin feature/your-task-name
   ```

## Current Status

This repository is ready for UI iteration and team collaboration. Since the data layer is mocked, the next natural steps are backend integration, persistent auth, payment integration, and real service booking APIs.

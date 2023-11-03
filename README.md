# bv_cayanqua

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## loctroi

LOCTROI project on the FLUTTER platform

## how to run

- fvm use 2.2.1
- fvm flutter run --flavor client -t lib/main-client.dart
- fvm flutter run --flavor doctor -t lib/main-doctor.dart

## How to build Android

1. Make clean and refresh pub libs
2. `flutter build appbundle --release --flavor client -t lib/main-client.dart`
3. `flutter build appbundle --release --flavor doctor -t lib/main-doctor.dart`

## How to build iOS

1. Clean and refresh pub libs
2. cd ios and pod get/install
3. cd ..
4. `flutter build ios --flavor client`
5. Using xcode or build and release

// **\* PLEASE RUN COMMAND BELOW FOR REBUILD MODELS \*\***
// flutter packages pub run build_runner build --delete-conflicting-outputs

flutter build apk --release --flavor client -t lib/main-client.dart
flutter build apk --release --flavor doctor -t lib/main-doctor.dart

# Mood Indigo 2025 - Official App

A beautiful Flutter application for **Mood Indigo 2025**, Asia's largest college cultural festival organized by IIT Bombay.

## Features

- **Splash Screen** - Animated splash with festival branding
- **Event Categories** - Browse events by category (Music, Dance, Drama, etc.)
- **Headliners Section** - Featured artists and performers
- **Schedule & Timeline** - Complete festival schedule with filtering
- **Aftermovie Player** - Embedded YouTube player for festival aftermovie
- **Team Section** - Meet the organizing team
- **Sponsors Section** - Festival sponsors showcase
- **Eateries & Shops** - On-campus food and shopping spots
- **Medical Facilities** - Emergency contacts and medical info
- **Dark/Light Theme** - Adaptive theming support
- **Responsive Design** - Works on mobile, tablet, and web

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** >= 3.10.4
- **Dart SDK** >= 3.0.0
- **Android Studio** / **VS Code** with Flutter extensions
- **Git**

### Verify Installation

```bash
flutter doctor
```

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/kovid150906/Moodi_assignment_app.git
cd Moodi_assignment_app/moodi_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

#### On Android Emulator/Device
```bash
flutter run
```

#### On Chrome (Web)
```bash
flutter run -d chrome
```

#### On iOS Simulator (macOS only)
```bash
flutter run -d ios
```

## Building for Production

### Android APK
```bash
flutter build apk --release
```
The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle
```bash
flutter build appbundle --release
```

### Web
```bash
flutter build web --release
```
The build output will be in `build/web/`

### iOS (macOS only)
```bash
flutter build ios --release
```

## Project Structure

```
moodi_app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── data/
│   │   └── moodi_data.dart       # Static data and constants
│   ├── models/
│   │   └── event_models.dart     # Data models
│   ├── screens/
│   │   ├── home_screen.dart      # Main home screen
│   │   └── splash_screen.dart    # Splash screen
│   ├── theme/
│   │   ├── app_theme.dart        # Theme configuration
│   │   └── colors.dart           # Color palette
│   └── widgets/
│       ├── common/
│       │   └── animated_background.dart
│       └── sections/
│           ├── aftermovie_section.dart
│           ├── did_you_know_section.dart
│           ├── eateries_section.dart
│           ├── event_categories.dart
│           ├── footer_section.dart
│           ├── headliners_section.dart
│           ├── medical_section.dart
│           ├── moodi_header.dart
│           ├── schedule_section.dart
│           ├── shops_spots_section.dart
│           ├── sponsors_section.dart
│           ├── team_section.dart
│           └── timeline_section.dart
├── assets/
│   ├── fonts/
│   ├── icons/
│   └── images/
│       └── team/
├── android/
├── ios/
├── web/
└── pubspec.yaml
```

## Dependencies

| Package | Version | Description |
|---------|---------|-------------|
| google_fonts | ^6.2.1 | Beautiful typography |
| flutter_animate | ^4.5.2 | Smooth animations |
| cached_network_image | ^3.4.1 | Image caching |
| shimmer | ^3.0.0 | Loading shimmer effects |
| url_launcher | ^6.3.1 | Open URLs and links |
| flutter_staggered_animations | ^1.1.1 | Staggered list animations |
| animated_text_kit | ^4.2.2 | Animated text effects |
| youtube_player_iframe | ^5.2.0 | YouTube video player |

## Troubleshooting

### Common Issues

**1. YouTube Video Not Loading**
- Ensure you have internet connectivity
- The video must allow embedding on external sites

**2. Images Not Loading**
- Run `flutter clean` and then `flutter pub get`
- Ensure assets are properly declared in `pubspec.yaml`

**3. Build Errors**
```bash
flutter clean
flutter pub get
flutter run
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is created for Mood Indigo 2025, IIT Bombay.

## Contact

For any queries, reach out to the development team.

---

Made with ❤️ for Mood Indigo 2025

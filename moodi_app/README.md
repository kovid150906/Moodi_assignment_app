# Mood Indigo 2025 - IIT Bombay's Cultural Festival App

A Flutter-based mobile application for Mood Indigo 2025, Asia's largest college cultural festival organized by IIT Bombay.

## Features

- **Splash Screen** - Animated splash screen with festival branding
- **Event Categories** - Browse events by categories (Music, Dance, Drama, etc.)
- **Headliners Section** - Featured artists and performers
- **Schedule & Timeline** - Complete festival schedule with timeline view
- **Aftermovie Player** - Embedded YouTube player for festival aftermovie
- **Team Section** - Meet the organizing team
- **Sponsors Section** - Festival sponsors showcase
- **Eateries & Shops** - Campus food and shopping guide
- **Medical Services** - Emergency medical information
- **Did You Know** - Fun facts about Mood Indigo
- **Dark/Light Theme** - Adaptive theming support
- **Responsive Design** - Works on mobile, tablet, and web

## Screenshots

*Coming soon*

## Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (^3.10.4 or higher)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- Android Studio / VS Code with Flutter extensions
- For Android: Android SDK
- For iOS: Xcode (macOS only)
- For Web: Chrome browser

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/kovid150906/Moodi_assignment_app.git
   cd Moodi_assignment_app/moodi_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   
   For Android:
   ```bash
   flutter run
   ```
   
   For iOS:
   ```bash
   flutter run -d ios
   ```
   
   For Web:
   ```bash
   flutter run -d chrome
   ```

## Build

### Android APK
```bash
flutter build apk --release
```
The APK will be generated at `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```
The web build will be in the `build/web` directory.

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
│       ├── common/               # Reusable widgets
│       └── sections/             # Screen sections
├── assets/
│   ├── fonts/                    # Custom fonts
│   ├── icons/                    # App icons
│   └── images/                   # Images and team photos
├── android/                      # Android-specific files
├── ios/                          # iOS-specific files
└── web/                          # Web-specific files
```

## Dependencies

| Package | Version | Description |
|---------|---------|-------------|
| google_fonts | ^6.2.1 | Google Fonts for typography |
| flutter_animate | ^4.5.2 | Animation utilities |
| cached_network_image | ^3.4.1 | Network image caching |
| shimmer | ^3.0.0 | Shimmer loading effects |
| url_launcher | ^6.3.1 | Open URLs in browser |
| flutter_staggered_animations | ^1.1.1 | Staggered list animations |
| animated_text_kit | ^4.2.2 | Text animations |
| youtube_player_iframe | ^5.2.0 | YouTube video player |

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is for educational and demonstration purposes.

## Contact

For any queries regarding the app, please reach out to the development team.

---

**Mood Indigo 2025** - *Where Dreams Meet Reality*

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MoodiApp());
}

class MoodiApp extends StatefulWidget {
  const MoodiApp({super.key});

  @override
  State<MoodiApp> createState() => _MoodiAppState();
}

class _MoodiAppState extends State<MoodiApp> {
  bool _isDarkMode = true; // Start in dark mode by default (fits the punk theme)
  bool _showSplash = true; // Show splash screen initially

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _completeSplash() {
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Indigo 2025',
      debugShowCheckedModeBanner: false,
      theme: MoodiTheme.lightTheme,
      darkTheme: MoodiTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: _showSplash
          ? SplashScreen(onComplete: _completeSplash)
          : MoodiHomeScreen(
              onToggleTheme: _toggleTheme,
              isDarkMode: _isDarkMode,
            ),
    );
  }
}

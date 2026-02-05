import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class MoodiTheme {
  MoodiTheme._();

  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: isDark ? MoodiColors.electricPurple : const Color(0xFF6200EA),
      onPrimary: Colors.white,
      secondary: MoodiColors.hotPink,
      onSecondary: Colors.white,
      error: MoodiColors.live,
      onError: Colors.white,
      surface: isDark ? MoodiColors.surfaceDark : MoodiColors.surfaceLight,
      onSurface: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          isDark ? MoodiColors.primaryDark : MoodiColors.primaryLight,
      textTheme: _textTheme(isDark),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.bebasNeue(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
          letterSpacing: 3,
        ),
        iconTheme: IconThemeData(
          color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
        ),
      ),
      cardTheme: CardThemeData(
        color: isDark ? MoodiColors.cardDark : MoodiColors.cardLight,
        elevation: 8,
        shadowColor: MoodiColors.electricPurple.withAlpha(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      iconTheme: IconThemeData(
        color: isDark ? MoodiColors.electricPurple : const Color(0xFF6200EA),
      ),
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight,
        labelStyle: GoogleFonts.inter(
          color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isDark
                ? MoodiColors.electricPurple.withAlpha(80)
                : const Color(0xFF6200EA).withAlpha(80),
          ),
        ),
      ),
    );
  }

  static TextTheme _textTheme(bool isDark) {
    final primary = isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight;
    final secondary =
        isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight;
    final muted = isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight;

    return TextTheme(
      displayLarge: GoogleFonts.bebasNeue(
        fontSize: 44,
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 2,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.bebasNeue(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 1.5,
        height: 1.1,
      ),
      displaySmall: GoogleFonts.bebasNeue(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: primary,
        letterSpacing: 1,
        height: 1.2,
      ),
      headlineLarge: GoogleFonts.rajdhani(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: primary,
        letterSpacing: 0.5,
      ),
      headlineMedium: GoogleFonts.rajdhani(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: primary,
        letterSpacing: 0.5,
      ),
      headlineSmall: GoogleFonts.rajdhani(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleLarge: GoogleFonts.rajdhani(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleMedium: GoogleFonts.rajdhani(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleSmall: GoogleFonts.rajdhani(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: secondary,
      ),
      bodyLarge: GoogleFonts.workSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primary,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.workSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondary,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.workSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: muted,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.bebasNeue(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: MoodiColors.hotPink,
        letterSpacing: 2,
      ),
      labelMedium: GoogleFonts.workSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: secondary,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.workSans(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: muted,
        letterSpacing: 1,
      ),
    );
  }
}

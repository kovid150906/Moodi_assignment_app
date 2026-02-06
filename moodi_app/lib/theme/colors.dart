import 'package:flutter/material.dart';

/// Mood Indigo 2025 Color Palette
/// Theme: "Fiery Red Sunset" - From deep midnight through scarlet to golden brilliance
/// Using a dramatic 10-color hot palette with passionate gradients
class MoodiColors {
  MoodiColors._();

  // Dark Mode Primary - Deep night tones
  static const Color primaryDark = Color(0xFF03071E);
  static const Color surfaceDark = Color(0xFF370617);
  static const Color cardDark = Color(0xFF4D0812);
  static const Color elevatedDark = Color(0xFF6A040F);

  // Light Mode Primary - Warm amber tones
  static const Color primaryLight = Color(0xFFFFF9F0);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFF3E8);
  static const Color elevatedLight = Color(0xFFFFEDD6);

  // ═══════════════════════════════════════════════════════════
  // PRIMARY PALETTE - Fiery Red Sunset (10 colors)
  // ═══════════════════════════════════════════════════════════
  
  /// Ultra-dark blue-black - #03071e
  static const Color inkBlack = Color(0xFF03071E);
  
  /// Mysterious bordeaux - #370617
  static const Color nightBordeaux = Color(0xFF370617);
  
  /// Intense red-black - #6a040f
  static const Color blackCherry = Color(0xFF6A040F);
  
  /// Deep vintage crimson - #9d0208
  static const Color oxblood = Color(0xFF9D0208);
  
  /// Passionate ember red - #d00000
  static const Color brickEmber = Color(0xFFD00000);
  
  /// Earthy reddish-orange - #dc2f02
  static const Color redOchre = Color(0xFFDC2F02);
  
  /// Burnished autumn - #e85d04
  static const Color autumnLeaf = Color(0xFFE85D04);
  
  /// Fierce dark orange - #f48c06
  static const Color darkOrange = Color(0xFFF48C06);
  
  /// Pure vibrant orange - #faa307
  static const Color orange = Color(0xFFFAA307);
  
  /// Fiery golden-orange - #ffba08
  static const Color amberFlame = Color(0xFFFFBA08);

  // ═══════════════════════════════════════════════════════════
  // LEGACY ALIASES (for backward compatibility)
  // ═══════════════════════════════════════════════════════════
  static const Color amberGold = amberFlame;
  static const Color blazeOrange = darkOrange;
  static const Color neonPink = brickEmber;
  static const Color blueViolet = oxblood;
  static const Color azureBlue = nightBordeaux;
  
  static const Color hotPink = redOchre;
  static const Color electricPurple = blackCherry;
  static const Color neonCyan = autumnLeaf;
  static const Color sunburstYellow = amberFlame;
  static const Color deepOrange = darkOrange;
  static const Color gold = orange;
  static const Color limeGreen = autumnLeaf;
  static const Color skyBlue = oxblood;
  static const Color coral = redOchre;
  static const Color mintGreen = orange;
  static const Color shockPink = brickEmber;

  // Text Colors - Fire-inspired
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFFFDDCC);
  static const Color textMutedDark = Color(0xFFFFAA88);

  static const Color textOnLight = Color(0xFF03071E);
  static const Color textSecondaryLight = Color(0xFF6A040F);
  static const Color textMutedLight = Color(0xFF9D0208);

  // Status
  static const Color live = brickEmber;

  // ═══════════════════════════════════════════════════════════
  // ADAPTIVE COLORS - Better contrast for light/dark modes
  // ═══════════════════════════════════════════════════════════
  
  /// Use this for accent colors that need good contrast in both modes
  static Color getAccentColor(bool isDark) {
    return isDark ? darkOrange : Color(0xFFB84000); // Darker orange for light mode
  }
  
  /// Safe icon/text accent color for both modes
  static Color getIconAccent(bool isDark) {
    return isDark ? amberFlame : Color(0xFFC85000); // Much darker for light mode
  }
  
  /// Calendar/date icon color
  static Color getCalendarColor(bool isDark) {
    return isDark ? darkOrange : Color(0xFFD84000);
  }
  
  /// Yellow/gold accent (replaces sunburstYellow) - Now uses blue in light mode
  static Color getYellowAccent(bool isDark) {
    return isDark ? amberFlame : Color(0xFF0C5BA0); // Blue for light mode
  }
  
  /// Red accent that works in both modes (replaces oxblood/blackCherry as text)
  static Color getRedAccent(bool isDark) {
    return isDark ? brickEmber : oxblood; // Brighter in dark, darker in light
  }
  
  /// Orange accent for decorative elements
  static Color getOrangeAccent(bool isDark) {
    return isDark ? orange : Color(0xFFB85A00);
  }
  
  /// Blue accent for time/date displays
  static Color getBlueAccent(bool isDark) {
    return isDark ? Color(0xFF4A9FF5) : Color(0xFF0C5BA0); // Bright blue for dark, deep blue for light
  }

  // ═══════════════════════════════════════════════════════════
  // GRADIENTS - Fiery transitions from night to golden flame
  // ═══════════════════════════════════════════════════════════

  /// Hero section dark - deep night embers
  static const LinearGradient heroGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      inkBlack,
      nightBordeaux,
      Color(0xFF4D0A13),
      blackCherry,
      nightBordeaux,
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  /// Hero section light - warm amber glow
  static const LinearGradient heroGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF8E7),
      Color(0xFFFFEDD6),
      Color(0xFFFFD6AA),
      Color(0xFFFFEDD6),
      Color(0xFFFFF8E7),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  /// Deep crimson fire
  static const LinearGradient fireGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [oxblood, brickEmber, redOchre, autumnLeaf],
  );

  /// Ocean of red (dark to bright red)
  static const LinearGradient oceanGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [nightBordeaux, blackCherry, oxblood, brickEmber],
  );

  /// Complete sunset blaze (dark to golden)
  static const LinearGradient oceanSunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blackCherry, brickEmber, redOchre, darkOrange, orange, amberFlame],
  );

  /// Neon night (dark crimson to orange)
  static const LinearGradient neonNightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [oxblood, redOchre, darkOrange],
  );

  /// Aurora glow (mid reds to orange)
  static const LinearGradient auroraGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brickEmber, autumnLeaf, orange],
  );

  /// Sunset brilliance (orange to golden)
  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [redOchre, autumnLeaf, darkOrange, orange, amberFlame],
  );

  /// Royal depths (darkest tones)
  static const LinearGradient royalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [inkBlack, nightBordeaux, blackCherry],
  );

  /// Full spectrum rainbow - night to golden flame
  static const LinearGradient rainbowGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [inkBlack, blackCherry, oxblood, brickEmber, redOchre, autumnLeaf, darkOrange, orange, amberFlame],
  );

  /// Section gradients variety
  static const List<LinearGradient> sectionGradients = [
    oceanSunsetGradient,
    fireGradient,
    oceanGradient,
    neonNightGradient,
    auroraGradient,
    sunsetGradient,
    royalGradient,
  ];
}

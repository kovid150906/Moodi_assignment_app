import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/colors.dart';
import '../../data/moodi_data.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? MoodiColors.heroGradientDark
              : MoodiColors.heroGradientLight,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status bar padding
            const SizedBox(height: 60),

            // Year badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? MoodiColors.electricPurple.withAlpha(120)
                      : const Color(0xFF6200EA).withAlpha(100),
                ),
                color: isDark
                    ? MoodiColors.electricPurple.withAlpha(25)
                    : const Color(0xFF6200EA).withAlpha(15),
              ),
              child: Text(
                MoodiData.festYear,
                style: GoogleFonts.spaceMono(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? MoodiColors.electricPurple
                      : const Color(0xFF6200EA),
                  letterSpacing: 3,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 100.ms)
                .slideY(begin: -0.3, end: 0, duration: 400.ms),

            const SizedBox(height: 10),

            // MOOD INDIGO animated title
            SizedBox(
              height: 48,
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    MoodiData.festName,
                    textStyle: GoogleFonts.spaceMono(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                    colors: [
                      isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                      MoodiColors.hotPink,
                      MoodiColors.neonCyan,
                      MoodiColors.getYellowAccent(isDark),
                      MoodiColors.electricPurple,
                    ],
                    speed: const Duration(milliseconds: 300),
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 200.ms)
                .scaleXY(begin: 0.9, end: 1, duration: 500.ms),

            const SizedBox(height: 8),

            // Theme name with shimmer
            Shimmer.fromColors(
              baseColor: isDark ? MoodiColors.hotPink : const Color(0xFFD500F9),
              highlightColor: isDark
                  ? MoodiColors.getYellowAccent(isDark)
                  : MoodiColors.hotPink,
              period: const Duration(seconds: 3),
              child: Text(
                '// ${MoodiData.festTheme.toUpperCase()} //',
                style: GoogleFonts.spaceMono(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 400.ms)
                .slideY(begin: 0.3, end: 0, duration: 400.ms),

            const SizedBox(height: 14),

            // Dates + Venue in one row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 13,
                  color: isDark
                      ? MoodiColors.textSecondaryDark
                      : MoodiColors.textSecondaryLight,
                ),
                const SizedBox(width: 5),
                Text(
                  MoodiData.festDates,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? MoodiColors.textSecondaryDark
                        : MoodiColors.textSecondaryLight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '\u2022',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark
                          ? MoodiColors.textMutedDark
                          : MoodiColors.textMutedLight,
                    ),
                  ),
                ),
                Icon(
                  Icons.location_on_rounded,
                  size: 13,
                  color: isDark
                      ? MoodiColors.textSecondaryDark
                      : MoodiColors.textSecondaryLight,
                ),
                const SizedBox(width: 4),
                Text(
                  MoodiData.festVenue,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? MoodiColors.textSecondaryDark
                        : MoodiColors.textSecondaryLight,
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 600.ms),

            const SizedBox(height: 18),

            // Bottom gradient border
            Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    MoodiColors.hotPink.withAlpha(isDark ? 180 : 120),
                    MoodiColors.electricPurple.withAlpha(isDark ? 200 : 140),
                    MoodiColors.neonCyan.withAlpha(isDark ? 180 : 120),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

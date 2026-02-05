import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(isDark),
            const SizedBox(height: 14),
            // Glassmorphism-style card
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withAlpha(15)
                        : Colors.white.withAlpha(180),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withAlpha(30)
                          : Colors.black.withAlpha(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Theme tagline with gradient
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            MoodiColors.fireGradient.createShader(bounds),
                        child: Text(
                          MoodiData.festTheme.toUpperCase(),
                          style: GoogleFonts.spaceMono(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        MoodiData.festTagline,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: isDark
                              ? MoodiColors.textSecondaryDark
                              : MoodiColors.textSecondaryLight,
                          height: 1.6,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Quick facts as horizontal chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _factChip(Icons.history_rounded, 'Est. 1971', MoodiColors.neonCyan, isDark),
                          _factChip(Icons.school_rounded, 'IIT Bombay', MoodiColors.electricPurple, isDark),
                          _factChip(Icons.public_rounded, 'Asia\'s Largest', MoodiColors.getYellowAccent(isDark), isDark),
                          _factChip(Icons.favorite_rounded, '54 Years', MoodiColors.hotPink, isDark),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.05, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }

  Widget _factChip(IconData icon, String text, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: color.withAlpha(isDark ? 25 : 20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(isDark ? 60 : 50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 6),
          Text(text, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return Row(
      children: [
        Container(
          width: 4, height: 28,
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            gradient: MoodiColors.oceanGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'ABOUT',
          style: GoogleFonts.spaceMono(
            fontSize: 20, fontWeight: FontWeight.bold,
            color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
            letterSpacing: 3,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colors.dart';
import '../common/texture_overlay.dart';

class MoodiHeader extends StatelessWidget {
  const MoodiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: statusBarHeight + 16,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            decoration: BoxDecoration(
              gradient: isDark ? MoodiColors.heroGradientDark : MoodiColors.heroGradientLight,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left side - Moodi Logo with black background to blend
                Container(
                  width: 56,
                  height: 56,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black, // Black bg to blend with logo
                    boxShadow: [
                      BoxShadow(
                        color: MoodiColors.getRedAccent(isDark).withAlpha(60),
                        blurRadius: 16,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: MoodiColors.getAccentColor(isDark).withAlpha(30),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/moodi_logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.black,
                        child: Icon(
                          Icons.celebration_rounded,
                          size: 28,
                          color: MoodiColors.getRedAccent(isDark),
                        ),
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.8, 0.8)),
            const SizedBox(width: 14),
            // Center - Title and info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main title with gradient
                  ShaderMask(
                    shaderCallback: (bounds) => MoodiColors.rainbowGradient.createShader(bounds),
                    child: Text(
                      'MOOD INDIGO',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 3,
                        height: 1.1,
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
                  const SizedBox(height: 6),
                  // Year and tagline
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: MoodiColors.fireGradient,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '2025',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'A Vortex of Vandalism',
                        style: GoogleFonts.workSans(
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
                  const SizedBox(height: 6),
                  // Dates
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 12,
                        color: MoodiColors.getCalendarColor(isDark),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'December 15-18, 2025',
                        style: GoogleFonts.workSans(
                          fontSize: 11,
                          color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
                ],
              ),
            ),
          ],
        ),
      ),
      // Texture overlay for header
      Positioned.fill(
        child: IgnorePointer(
          child: TextureOverlay(opacity: isDark ? 0.06 : 0.03),
        ),
      ),
    ],
      ),
    );
  }
}

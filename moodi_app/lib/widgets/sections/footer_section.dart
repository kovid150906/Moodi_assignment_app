import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: EdgeInsets.fromLTRB(24, 28, 24, 28 + bottomPadding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [MoodiColors.primaryDark, const Color(0xFF050210)]
                : [MoodiColors.primaryLight, const Color(0xFFE8DFFF)],
          ),
        ),
        child: Column(
          children: [
            // Gradient divider
            Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    MoodiColors.hotPink.withAlpha(isDark ? 120 : 80),
                    MoodiColors.electricPurple.withAlpha(isDark ? 120 : 80),
                    MoodiColors.neonCyan.withAlpha(isDark ? 120 : 80),
                    Colors.transparent,
                  ],
                ),
              ),
            ).animate().scaleX(duration: 600.ms, curve: Curves.easeOutCubic),

            const SizedBox(height: 20),

            ShaderMask(
              shaderCallback: (bounds) => MoodiColors.neonNightGradient.createShader(bounds),
              child: Text(
                'MOOD INDIGO',
                style: GoogleFonts.spaceMono(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 6),
              ),
            ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

            const SizedBox(height: 4),

            Text(
              'IIT BOMBAY',
              style: GoogleFonts.inter(fontSize: 12, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight, letterSpacing: 3, fontWeight: FontWeight.w500),
            ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

            const SizedBox(height: 18),

            // Social row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialBtn(Icons.language_rounded, 'Website', 'https://moodi.org', MoodiColors.neonCyan, isDark),
                const SizedBox(width: 12),
                _socialBtn(Icons.camera_alt_rounded, 'Instagram', 'https://instagram.com/iitb.moodindigo', MoodiColors.hotPink, isDark),
                const SizedBox(width: 12),
                _socialBtn(Icons.alternate_email_rounded, 'Twitter', 'https://twitter.com/iitb_moodi', MoodiColors.skyBlue, isDark),
              ],
            ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideY(begin: 0.2),

            const SizedBox(height: 20),

            Text(
              MoodiData.festDescription,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 11, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight, height: 1.6),
            ).animate().fadeIn(duration: 500.ms, delay: 500.ms),

            const SizedBox(height: 20),

            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, (isDark ? Colors.white : Colors.black).withAlpha(20), Colors.transparent],
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Made for Moodi Assignment',
              style: GoogleFonts.inter(fontSize: 10, color: (isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight).withAlpha(120)),
            ).animate().fadeIn(duration: 500.ms, delay: 700.ms),
          ],
        ),
      ),
    );
  }

  Widget _socialBtn(IconData icon, String label, String url, Color color, bool isDark) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(isDark ? 20 : 15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(isDark ? 50 : 35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }
}

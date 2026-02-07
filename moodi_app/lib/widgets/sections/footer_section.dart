import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/moodi_data.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    // Footer text color
    const footerTextColor = Color(0xFF720026);
    const moodiTextColor = Color(0xFFF7FFF7); // Light mint color for MOOD INDIGO
    
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFFEDF2FB) : null,
        ),
        child: Stack(
          children: [
            // Liquid glass gradient background for light mode
            if (!isDark)
              Positioned.fill(
                child: _LiquidGlassBackground(),
              ),
            // Content
            Padding(
              padding: EdgeInsets.fromLTRB(24, 28, 24, 28 + bottomPadding),
              child: Column(
                children: [
                  // Gradient divider
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          (isDark ? const Color(0xFF720026) : moodiTextColor).withAlpha(isDark ? 120 : 180),
                          (isDark ? const Color(0xFF720026) : moodiTextColor).withAlpha(isDark ? 120 : 180),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ).animate().scaleX(duration: 600.ms, curve: Curves.easeOutCubic),

                  const SizedBox(height: 20),

                  // MOOD INDIGO text
                  Text(
                    'MOOD INDIGO',
                    style: GoogleFonts.spaceMono(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: isDark ? const Color(0xFFFF6D00) : moodiTextColor, 
                      letterSpacing: 6,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

                  const SizedBox(height: 4),

                  Text(
                    'IIT BOMBAY',
                    style: GoogleFonts.inter(
                      fontSize: 12, 
                      color: isDark ? footerTextColor : Colors.white70, 
                      letterSpacing: 3, 
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

                  const SizedBox(height: 18),

                  // Social row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialBtn(Icons.language_rounded, 'Website', 'https://moodi.org', isDark ? const Color(0xFF720026) : moodiTextColor, isDark),
                      const SizedBox(width: 12),
                      _socialBtn(Icons.camera_alt_rounded, 'Instagram', 'https://instagram.com/iitb.moodindigo', isDark ? const Color(0xFF720026) : moodiTextColor, isDark),
                      const SizedBox(width: 12),
                      _socialBtn(Icons.alternate_email_rounded, 'Twitter', 'https://twitter.com/iitb_moodi', isDark ? const Color(0xFF720026) : moodiTextColor, isDark),
                    ],
                  ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideY(begin: 0.2),

                  const SizedBox(height: 20),

                  Text(
                    MoodiData.festDescription,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 11, 
                      color: isDark ? footerTextColor : Colors.white70, 
                      height: 1.6,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 500.ms),

                  const SizedBox(height: 20),

                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent, 
                          (isDark ? footerTextColor : Colors.white).withAlpha(30), 
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Made for Moodi Assignment',
                    style: GoogleFonts.inter(
                      fontSize: 10, 
                      color: isDark ? footerTextColor.withAlpha(180) : Colors.white54,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 700.ms),
                ],
              ),
            ),
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
          color: color.withAlpha(isDark ? 20 : 30),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(isDark ? 50 : 80)),
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

/// Liquid glass background with radial gradient (black/blue center, orange edges)
class _LiquidGlassBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base black background
        Container(color: const Color(0xFF0A0A0A)),
        // Center blue glow
        Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  const Color(0xFF0D47A1).withAlpha(180), // Deep blue center
                  const Color(0xFF1A237E).withAlpha(120), // Darker blue
                  const Color(0xFF0A0A0A).withAlpha(200), // Black
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),
        // Orange edge glow - top
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: const Alignment(0, -0.6),
              colors: [
                const Color(0xFFE65100).withAlpha(60),
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Orange edge glow - bottom
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: const Alignment(0, 0.6),
              colors: [
                const Color(0xFFE65100).withAlpha(60),
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Orange edge glow - left
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: const Alignment(-0.6, 0),
              colors: [
                const Color(0xFFE65100).withAlpha(40),
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Orange edge glow - right
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: const Alignment(0.6, 0),
              colors: [
                const Color(0xFFE65100).withAlpha(40),
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Noise texture
        CustomPaint(
          painter: NoisePainter(),
          size: Size.infinite,
        ),
      ],
    );
  }
}

/// Custom painter for noise texture effect
class NoisePainter extends CustomPainter {
  final Random _random = Random(42); // Fixed seed for consistent noise
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 1;
    
    // Create subtle noise dots
    for (int i = 0; i < 2000; i++) {
      final x = _random.nextDouble() * size.width;
      final y = _random.nextDouble() * size.height;
      final alpha = (_random.nextDouble() * 40).toInt(); // Very subtle
      paint.color = Colors.white.withAlpha(alpha);
      canvas.drawCircle(Offset(x, y), 0.5, paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

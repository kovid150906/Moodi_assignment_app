import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colors.dart';

class MoodiHeader extends StatelessWidget {
  const MoodiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(
          top: statusBarHeight + 4,
          left: 12,
          right: 12,
          bottom: 8,
        ),
        decoration: const BoxDecoration(
          color: Colors.black, // Solid black top bar
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side - Bitmoji/Avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: MoodiColors.neonNightGradient,
                border: Border.all(
                  color: const Color(0xFFFF6D00).withAlpha(100),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            // Center - Logo and Title
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/moodi_logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.black,
                        child: const Icon(
                          Icons.celebration_rounded,
                          size: 20,
                          color: Color(0xFFFF6D00),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'MOOD INDIGO',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF6D00),
                    letterSpacing: 2,
                    height: 1.1,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        gradient: MoodiColors.fireGradient,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        '2025',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 8,
                      color: Color(0xFFFF6D00),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      'Dec 15-18',
                      style: GoogleFonts.workSans(
                        fontSize: 8,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            // Right side - space for theme toggle
            const SizedBox(width: 36),
          ],
        ),
      ),
    );
  }
}

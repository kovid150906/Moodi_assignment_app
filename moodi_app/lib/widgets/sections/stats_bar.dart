import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';
import '../../models/event_models.dart';

class StatsBarWidget extends StatelessWidget {
  const StatsBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [const Color(0xFF1E1045), const Color(0xFF2D1660)]
                : [const Color(0xFFEDE7F6), const Color(0xFFD1C4E9)],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? MoodiColors.electricPurple.withAlpha(50)
                : const Color(0xFF6200EA).withAlpha(40),
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? MoodiColors.electricPurple.withAlpha(20)
                  : const Color(0xFF6200EA).withAlpha(15),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: MoodiData.stats.asMap().entries.map((entry) {
            final stat = entry.value;
            final index = entry.key;
            final accentColors = [
              MoodiColors.neonCyan,
              MoodiColors.hotPink,
              MoodiColors.getYellowAccent(isDark),
              MoodiColors.limeGreen,
            ];
            return Expanded(
              child: _StatItem(
                stat: stat,
                accentColor: accentColors[index % accentColors.length],
                isDark: isDark,
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: (200 + index * 150).ms)
                  .slideY(begin: 0.3, duration: 500.ms, delay: (200 + index * 150).ms, curve: Curves.easeOutCubic),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final FestStat stat;
  final Color accentColor;
  final bool isDark;
  const _StatItem({required this.stat, required this.accentColor, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(stat.icon, color: accentColor, size: 20),
        const SizedBox(height: 6),
        Text(
          stat.value,
          style: GoogleFonts.spaceMono(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          stat.label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

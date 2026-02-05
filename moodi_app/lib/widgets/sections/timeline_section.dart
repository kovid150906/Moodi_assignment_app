import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';
import '../../models/event_models.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isDark),
          const SizedBox(height: 16),
          // Horizontal scrolling timeline
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: MoodiData.timeline.length,
              itemBuilder: (context, index) {
                return _TimelineCard(
                  entry: MoodiData.timeline[index],
                  index: index,
                  isDark: isDark,
                  isLast: index == MoodiData.timeline.length - 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 4, height: 28,
            decoration: BoxDecoration(
              gradient: MoodiColors.royalGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OUR LEGACY',
                style: GoogleFonts.spaceMono(
                  fontSize: 20, fontWeight: FontWeight.bold,
                  color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                  letterSpacing: 3,
                ),
              ),
              Text(
                '54 years of cultural excellence',
                style: GoogleFonts.inter(fontSize: 12, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final TimelineEntry entry;
  final int index;
  final bool isDark;
  final bool isLast;

  const _TimelineCard({required this.entry, required this.index, required this.isDark, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final isCurrent = entry.year == '2025';
    final colors = [
      MoodiColors.neonCyan,
      MoodiColors.electricPurple,
      MoodiColors.hotPink,
      MoodiColors.getYellowAccent(isDark),
      MoodiColors.limeGreen,
      MoodiColors.deepOrange,
      MoodiColors.gold,
      MoodiColors.coral,
    ];
    final color = isCurrent ? MoodiColors.hotPink : colors[index % colors.length];
    final gradients = MoodiColors.sectionGradients;
    final gradient = gradients[index % gradients.length];

    return Row(
      children: [
        SizedBox(
          width: 160,
          child: Column(
            children: [
              // Timeline connector + dot
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    // Left connector line
                    if (index > 0)
                      Container(width: 40, height: 2, color: colors[(index - 1) % colors.length].withAlpha(80))
                    else
                      const SizedBox(width: 40),
                    // Dot
                    Container(
                      width: isCurrent ? 20 : 14,
                      height: isCurrent ? 20 : 14,
                      decoration: BoxDecoration(
                        gradient: isCurrent ? gradient : null,
                        color: isCurrent ? null : color.withAlpha(60),
                        shape: BoxShape.circle,
                        border: Border.all(color: color, width: 2),
                        boxShadow: isCurrent
                            ? [BoxShadow(color: color.withAlpha(120), blurRadius: 12)]
                            : [],
                      ),
                      child: isCurrent
                          ? const Icon(Icons.bolt_rounded, size: 10, color: Colors.white)
                          : null,
                    ),
                    // Right connector line
                    if (!isLast)
                      Expanded(child: Container(height: 2, color: color.withAlpha(80)))
                    else
                      const Expanded(child: SizedBox()),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Year label
              ShaderMask(
                shaderCallback: (bounds) => gradient.createShader(bounds),
                child: Text(
                  entry.year,
                  style: GoogleFonts.spaceMono(
                    fontSize: isCurrent ? 22 : 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? color.withAlpha(isDark ? 25 : 20)
                        : (isDark ? MoodiColors.cardDark : MoodiColors.cardLight),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: color.withAlpha(isDark ? 50 : 35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                          color: color.withAlpha(25),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(entry.icon, size: 16, color: color),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.title,
                        style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w600,
                          color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                        ),
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Flexible(
                        child: Text(
                          entry.description,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                            height: 1.4,
                          ),
                          maxLines: 3, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const SizedBox(width: 4),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: (index * 100).ms).slideX(begin: 0.15, curve: Curves.easeOutCubic);
  }
}

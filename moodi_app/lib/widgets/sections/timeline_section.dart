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
          // Responsive timeline layout
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              // Use wrap layout on larger screens, horizontal scroll on smaller
              if (screenWidth >= 1000) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(MoodiData.timeline.length, (index) {
                      return SizedBox(
                        width: 200,
                        height: 220,
                        child: _TimelineCard(
                          entry: MoodiData.timeline[index],
                          index: index,
                          isDark: isDark,
                          isLast: index == MoodiData.timeline.length - 1,
                        ),
                      );
                    }),
                  ),
                );
              } else {
                return SizedBox(
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
                );
              }
            },
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
                style: GoogleFonts.anton(
                  fontSize: 22, fontWeight: FontWeight.w400,
                  color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                  letterSpacing: 2,
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

  void _showTimelineDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      barrierColor: Colors.black.withAlpha(150),
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.of(ctx).pop(),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(ctx).pop(),
                child: Container(color: Colors.transparent),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {},
                child: _TimelineDetailSheet(entry: entry, isDark: isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              // Year label - fixed visibility
              Text(
                entry.year,
                style: GoogleFonts.spaceMono(
                  fontSize: isCurrent ? 22 : 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                  shadows: [
                    Shadow(
                      color: color.withAlpha(40),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Card - now tappable
              Expanded(
                child: GestureDetector(
                  onTap: () => _showTimelineDetail(context),
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
              ),
            ],
          ),
        ),
        if (!isLast) const SizedBox(width: 4),
      ],
    ).animate().fadeIn(duration: 500.ms, delay: (index * 100).ms).slideX(begin: 0.15, curve: Curves.easeOutCubic);
  }
}

/// Detailed timeline information popup
class _TimelineDetailSheet extends StatelessWidget {
  final TimelineEntry entry;
  final bool isDark;

  const _TimelineDetailSheet({required this.entry, required this.isDark});

  @override
  Widget build(BuildContext context) {
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
    final color = colors[int.parse(entry.year) % colors.length];
    
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.85,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? MoodiColors.cardDark : MoodiColors.surfaceLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              // Drag handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withAlpha(60) : Colors.black.withAlpha(30),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Year badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: color.withAlpha(20),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: color.withAlpha(60)),
                        ),
                        child: Text(
                          entry.year,
                          style: GoogleFonts.spaceMono(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Icon
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: color.withAlpha(20),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(entry.icon, size: 30, color: color),
                      ),
                      const SizedBox(height: 16),
                      // Title
                      Text(
                        entry.title,
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : MoodiColors.textOnLight,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Divider
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              color.withAlpha(80),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Description
                      Text(
                        entry.description,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                          height: 1.7,
                        ),
                      ),
                      if (entry.year == '2025') ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                color.withAlpha(30),
                                color.withAlpha(10),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: color.withAlpha(60)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.celebration_rounded, color: color, size: 24),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Current Edition - Join us this year!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

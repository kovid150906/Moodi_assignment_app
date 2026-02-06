import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';
import '../../models/event_models.dart';

class EventCategoriesSection extends StatelessWidget {
  const EventCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isDark),
          const SizedBox(height: 16),
          // Responsive grid of category cards
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              // Determine column count based on screen width
              int crossAxisCount = 2;
              if (screenWidth >= 1400) {
                crossAxisCount = 5;
              } else if (screenWidth >= 1000) {
                crossAxisCount = 4;
              } else if (screenWidth >= 700) {
                crossAxisCount = 3;
              }
              
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: MoodiData.categories.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: crossAxisCount,
                        duration: const Duration(milliseconds: 500),
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: _CategoryCard(
                              category: MoodiData.categories[index],
                              index: index,
                              isDark: isDark,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
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
              gradient: MoodiColors.neonNightGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EVENTS',
                style: GoogleFonts.spaceMono(
                  fontSize: 20, fontWeight: FontWeight.bold,
                  color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                  letterSpacing: 3,
                ),
              ),
              Text(
                'Tap to explore',
                style: GoogleFonts.inter(fontSize: 12, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final EventCategory category;
  final int index;
  final bool isDark;

  const _CategoryCard({required this.category, required this.index, required this.isDark});

  void _showCategoryEvents(BuildContext context) {
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
                child: _CategoryEventsSheet(category: category, isDark: isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gradients = MoodiColors.sectionGradients;
    final gradient = gradients[index % gradients.length];

    return GestureDetector(
      onTap: () => _showCategoryEvents(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [MoodiColors.cardDark, MoodiColors.elevatedDark]
                : [MoodiColors.cardLight, MoodiColors.elevatedLight],
          ),
          border: Border.all(color: category.color.withAlpha(isDark ? 60 : 40)),
          boxShadow: [
            BoxShadow(color: category.color.withAlpha(20), blurRadius: 12, spreadRadius: 1),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon with gradient background
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(category.icon, size: 22, color: Colors.white),
              ),
              const Spacer(),
              Text(
                category.name,
                style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w700,
                  color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${category.events.length} events',
                style: GoogleFonts.inter(fontSize: 11, color: category.color, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                category.description,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                ),
                maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryEventsSheet extends StatelessWidget {
  final EventCategory category;
  final bool isDark;

  const _CategoryEventsSheet({required this.category, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
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
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: category.color.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(category.icon, size: 20, color: category.color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(category.name, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : MoodiColors.textOnLight)),
                          Text(category.description, style: GoogleFonts.inter(fontSize: 12, color: category.color)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: category.events.length,
                  itemBuilder: (context, index) {
                    final event = category.events[index];
                    return _EventCard(event: event, color: category.color, isDark: isDark, index: index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  final Event event;
  final Color color;
  final bool isDark;
  final int index;

  const _EventCard({required this.event, required this.color, required this.isDark, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(event.title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: isDark ? Colors.white : MoodiColors.textOnLight)),
          if (event.subtitle.isNotEmpty)
            Text(event.subtitle, style: GoogleFonts.inter(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              _infoChip(Icons.calendar_today_rounded, event.date),
              const SizedBox(width: 10),
              _infoChip(Icons.access_time_rounded, event.time),
              const SizedBox(width: 10),
              Flexible(child: _infoChip(Icons.location_on_rounded, event.venue)),
            ],
          ),
          const SizedBox(height: 8),
          Text(event.description, style: GoogleFonts.inter(fontSize: 12, color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight, height: 1.5), maxLines: 3, overflow: TextOverflow.ellipsis),
          if (event.tags.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6, runSpacing: 6,
              children: event.tags.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withAlpha(40)),
                ),
                child: Text('#$tag', style: GoogleFonts.inter(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
              )).toList(),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: (index * 80).ms).slideY(begin: 0.1);
  }

  Widget _infoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight),
        const SizedBox(width: 4),
        Flexible(child: Text(text, style: GoogleFonts.inter(fontSize: 10, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}

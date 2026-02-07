import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';
import '../../models/event_models.dart';

class EventCategoriesSection extends StatefulWidget {
  const EventCategoriesSection({super.key});

  @override
  State<EventCategoriesSection> createState() => _EventCategoriesSectionState();
}

class _EventCategoriesSectionState extends State<EventCategoriesSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isDark),
          const SizedBox(height: 16),
          // Collapsible content
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: _isExpanded
                ? _buildCategoriesGrid(isDark)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(bool isDark) {
    return LayoutBuilder(
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
          );
  }

  Widget _buildSectionHeader(bool isDark) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Padding(
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
                  style: GoogleFonts.anton(
                    fontSize: 22, fontWeight: FontWeight.w400,
                    color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  _isExpanded ? 'Tap to collapse' : 'Tap to explore',
                  style: GoogleFonts.inter(fontSize: 12, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight),
                ),
              ],
            ),
            const Spacer(),
            AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                size: 28,
              ),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
      ),
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

  void _showEventDetail(BuildContext context) {
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
                child: _EventDetailSheet(event: event, color: color, isDark: isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEventDetail(context),
      child: Container(
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
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withAlpha(60)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Tap for details', style: GoogleFonts.inter(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded, size: 12, color: color),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: (index * 80).ms).slideY(begin: 0.1));
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

/// Detailed event information popup
class _EventDetailSheet extends StatelessWidget {
  final Event event;
  final Color color;
  final bool isDark;

  const _EventDetailSheet({required this.event, required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event image if available
                      if (event.imageUrl.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            event.imageUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              height: 180,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [color.withAlpha(40), color.withAlpha(20)],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(Icons.event, size: 60, color: color.withAlpha(100)),
                            ),
                          ),
                        ),
                      if (event.imageUrl.isNotEmpty) const SizedBox(height: 16),
                      // Event title
                      Text(
                        event.title,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : MoodiColors.textOnLight,
                        ),
                      ),
                      if (event.subtitle.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          event.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      // Event details
                      _buildDetailRow(Icons.calendar_today_rounded, 'Date', event.date),
                      const SizedBox(height: 12),
                      _buildDetailRow(Icons.access_time_rounded, 'Time', event.time),
                      const SizedBox(height: 12),
                      _buildDetailRow(Icons.location_on_rounded, 'Venue', event.venue),
                      const SizedBox(height: 20),
                      // Directions button
                      InkWell(
                        onTap: () async {
                          final uri = Uri.parse(event.mapsUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color, color.withAlpha(180)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: color.withAlpha(60),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.directions_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Get Directions',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Divider
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              color.withAlpha(60),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Description
                      Text(
                        'About',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : MoodiColors.textOnLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                          height: 1.6,
                        ),
                      ),
                      // Tags
                      if (event.tags.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text(
                          'Tags',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : MoodiColors.textOnLight,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: event.tags.map((tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: color.withAlpha(20),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: color.withAlpha(60)),
                            ),
                            child: Text(
                              '#$tag',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )).toList(),
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

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isDark ? Colors.white : MoodiColors.textOnLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

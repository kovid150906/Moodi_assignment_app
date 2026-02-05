import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';
import '../../models/event_models.dart';

class HeadlinersSection extends StatefulWidget {
  const HeadlinersSection({super.key});

  @override
  State<HeadlinersSection> createState() => _HeadlinersSectionState();
}

class _HeadlinersSectionState extends State<HeadlinersSection> {
  late final PageController _pageController;
  Timer? _autoSlideTimer;
  int _currentPage = 0;
  static const int _infiniteMultiplier = 10000;
  static const int _startingPage = 5000;

  @override
  void initState() {
    super.initState();
    final totalHeadliners = MoodiData.headliners.length;
    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: _startingPage * totalHeadliners,
    );
    _currentPage = _startingPage * totalHeadliners;
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _showHeadlinerPopup(BuildContext context, Headliner headliner, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradients = [
      MoodiColors.fireGradient,
      MoodiColors.oceanGradient,
      MoodiColors.neonNightGradient,
      MoodiColors.sunsetGradient,
    ];

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
            // Barrier - tap to dismiss
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(ctx).pop(),
                child: Container(color: Colors.transparent),
              ),
            ),
            // Actual popup
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {}, // Prevent closing when tapping popup content
                child: _HeadlinerPopup(
                  headliner: headliner,
                  gradient: gradients[index % gradients.length],
                  isDark: isDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isDark),
          const SizedBox(height: 12),
          // Page indicator
          _buildPageIndicator(isDark),
          const SizedBox(height: 8),
          SizedBox(
            height: 340,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemCount: MoodiData.headliners.length * _infiniteMultiplier,
              itemBuilder: (context, index) {
                final actualIndex = index % MoodiData.headliners.length;
                return GestureDetector(
                  onTap: () => _showHeadlinerPopup(context, MoodiData.headliners[actualIndex], actualIndex),
                  child: _HeadlinerCard(
                    headliner: MoodiData.headliners[actualIndex],
                    index: actualIndex,
                    isDark: isDark,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isDark) {
    final actualPage = _currentPage % MoodiData.headliners.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(MoodiData.headliners.length, (i) {
        final isActive = i == actualPage;
        final colors = [MoodiColors.hotPink, MoodiColors.neonCyan, MoodiColors.getYellowAccent(isDark), MoodiColors.limeGreen];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? colors[i % colors.length]
                : (isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight),
          ),
        );
      }),
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
              gradient: MoodiColors.fireGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HEADLINERS',
                style: GoogleFonts.bebasNeue(
                  fontSize: 26, fontWeight: FontWeight.w600,
                  color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                  letterSpacing: 3,
                  height: 1.1,
                ),
              ),
              Text(
                'Tap a card for details',
                style: GoogleFonts.workSans(fontSize: 12, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: MoodiColors.live.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: MoodiColors.live.withAlpha(80)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 6, height: 6, decoration: const BoxDecoration(color: MoodiColors.live, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text('4 NIGHTS', style: GoogleFonts.bebasNeue(fontSize: 11, fontWeight: FontWeight.w600, color: MoodiColors.live, letterSpacing: 1.5)),
              ],
            ),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1, curve: Curves.easeOut),
    );
  }
}

class _HeadlinerCard extends StatelessWidget {
  final Headliner headliner;
  final int index;
  final bool isDark;

  const _HeadlinerCard({required this.headliner, required this.index, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final gradients = [MoodiColors.fireGradient, MoodiColors.oceanGradient, MoodiColors.neonNightGradient, MoodiColors.sunsetGradient];
    final gradient = gradients[index % gradients.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [MoodiColors.cardDark, MoodiColors.elevatedDark]
              : [MoodiColors.cardLight, MoodiColors.elevatedLight],
        ),
        border: Border.all(color: gradient.colors[0].withAlpha(60)),
        boxShadow: [
          BoxShadow(color: gradient.colors[0].withAlpha(30), blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SizedBox(
              height: 190,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  headliner.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: headliner.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: isDark ? const Color(0xFF1E1045) : const Color(0xFFE0E0E0),
                            highlightColor: isDark ? const Color(0xFF2D1660) : const Color(0xFFF5F5F5),
                            child: Container(color: isDark ? const Color(0xFF1E1045) : const Color(0xFFE0E0E0)),
                          ),
                          errorWidget: (context, url, error) => _buildFallback(gradient),
                        )
                      : _buildFallback(gradient),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withAlpha(200)],
                      ),
                    ),
                  ),
                  // Day badge with gradient
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(headliner.day, style: GoogleFonts.bebasNeue(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 1.5)),
                    ),
                  ),
                  // Date badge
                  Positioned(
                    top: 12, right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(130),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white.withAlpha(30)),
                      ),
                      child: Text(headliner.date, style: GoogleFonts.workSans(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headliner.name,
                      style: GoogleFonts.rajdhani(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : MoodiColors.textOnLight, letterSpacing: 0.5),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(headliner.genre, style: GoogleFonts.workSans(fontSize: 12, color: gradient.colors[0], fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded, color: isDark ? MoodiColors.neonCyan : const Color(0xFF0091EA), size: 14),
                        const SizedBox(width: 6),
                        Text(headliner.time, style: GoogleFonts.workSans(fontSize: 12, color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('TAP', style: GoogleFonts.bebasNeue(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 1.5)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: (index * 150).ms).slideX(begin: 0.15, curve: Curves.easeOutCubic);
  }

  Widget _buildFallback(LinearGradient gradient) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gradient.colors[0].withAlpha(100), const Color(0xFF0D0519)],
        ),
      ),
      child: Center(
        child: Icon(Icons.music_note_rounded, size: 48, color: gradient.colors[0].withAlpha(120)),
      ),
    );
  }
}

class _HeadlinerPopup extends StatelessWidget {
  final Headliner headliner;
  final LinearGradient gradient;
  final bool isDark;

  const _HeadlinerPopup({required this.headliner, required this.gradient, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? MoodiColors.cardDark : MoodiColors.surfaceLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withAlpha(60) : Colors.black.withAlpha(30),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Hero image
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 220,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      headliner.imageUrl.isNotEmpty
                          ? CachedNetworkImage(imageUrl: headliner.imageUrl, fit: BoxFit.cover)
                          : Container(
                              decoration: BoxDecoration(gradient: gradient),
                              child: const Center(child: Icon(Icons.music_note, size: 64, color: Colors.white54)),
                            ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withAlpha(180)],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16, left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(8)),
                          child: Text(headliner.day, style: GoogleFonts.spaceMono(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms).scaleXY(begin: 0.95),
                // Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(headliner.name, style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: isDark ? Colors.white : MoodiColors.textOnLight)),
                      const SizedBox(height: 4),
                      // Genre with gradient text effect
                      ShaderMask(
                        shaderCallback: (bounds) => gradient.createShader(bounds),
                        child: Text(headliner.genre, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                      ),
                      const SizedBox(height: 16),
                      // Info chips row
                      Row(
                        children: [
                          _infoChip(Icons.calendar_today_rounded, headliner.date, gradient),
                          const SizedBox(width: 10),
                          _infoChip(Icons.access_time_rounded, headliner.time, gradient),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: gradient.colors[0].withAlpha(40)),
                        ),
                        child: Text(
                          headliner.description,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                            height: 1.6,
                          ),
                        ),
                      ).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideY(begin: 0.1),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoChip(IconData icon, String text, LinearGradient gradient) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: gradient.colors[0].withAlpha(20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: gradient.colors[0].withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: gradient.colors[0]),
          const SizedBox(width: 6),
          Text(text, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: gradient.colors[0])),
        ],
      ),
    );
  }
}

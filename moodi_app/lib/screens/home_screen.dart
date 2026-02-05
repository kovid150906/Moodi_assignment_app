import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';
import '../widgets/sections/moodi_header.dart';
import '../widgets/sections/headliners_section.dart';
import '../widgets/sections/did_you_know_section.dart';
import '../widgets/sections/event_categories.dart';
import '../widgets/sections/schedule_section.dart';
import '../widgets/sections/timeline_section.dart';
import '../widgets/sections/sponsors_section.dart';
import '../widgets/sections/footer_section.dart';
import '../widgets/common/dividers.dart';
import '../widgets/common/texture_overlay.dart';

class MoodiHomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const MoodiHomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<MoodiHomeScreen> createState() => _MoodiHomeScreenState();
}

class _MoodiHomeScreenState extends State<MoodiHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll > 0) {
      setState(() {
        _scrollProgress = (_scrollController.offset / maxScroll).clamp(0.0, 1.0);
        _showFab = _scrollController.offset > 300;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF000000), // Pure black
                    const Color(0xFF0A0001), // Almost black with red tint
                    const Color(0xFF1A0003), // Very dark red
                    const Color(0xFF2D0005), // Deep black-red
                    const Color(0xFF1A0003), // Very dark red
                    const Color(0xFF000000), // Pure black
                  ]
                : [
                    const Color(0xFFFFF9F0), // Soft cream
                    const Color(0xFFFFF3E0), // Light peachy
                    const Color(0xFFFFEDD6), // Warm amber
                    const Color(0xFFFFE5C0), // Golden sand
                    const Color(0xFFFFF3E0), // Light peachy
                    const Color(0xFFFFF9F0), // Soft cream
                  ],
            stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Texture overlay for depth
            TextureOverlay(opacity: isDark ? 0.08 : 0.05),
            // Geometric pattern
            GeometricPattern(
              color: isDark ? MoodiColors.brickEmber : const Color(0xFF9D0208),
              opacity: isDark ? 0.03 : 0.02,
            ),
            // Main content
            CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header with MOOD INDIGO title + bitmoji
              const MoodiHeader(),
              const SectionDivider(height: 8),
              // Headliners
              const HeadlinersSection(),
              const SectionDivider(),
              const GradientDivider(gradient: MoodiColors.fireGradient),
              const SectionDivider(height: 12),
              // Did You Know facts section
              const SliverToBoxAdapter(child: DidYouKnowSection()),
              const SectionDivider(),
              const GradientDivider(gradient: MoodiColors.neonNightGradient),
              const SectionDivider(height: 12),
              const ScheduleSection(),
              const SectionDivider(),
              const GradientDivider(gradient: MoodiColors.oceanGradient),
              const SectionDivider(height: 12),
              const EventCategoriesSection(),
              const SectionDivider(),
              const GradientDivider(gradient: MoodiColors.auroraGradient),
              const SectionDivider(height: 12),
              const TimelineSection(),
              const SectionDivider(),
              const GradientDivider(gradient: MoodiColors.sunsetGradient),
              const SectionDivider(height: 12),
              const SponsorsSection(),
              const SectionDivider(),
              const FooterSection(),
              // Bottom safe area padding
              SliverToBoxAdapter(
                child: SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
              ),
            ],
          ),

          // Scroll progress — multi-color gradient bar
          Positioned(
            top: 0, left: 0, right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _scrollProgress > 0.01 ? 2.5 : 0,
              child: LinearProgressIndicator(
                value: _scrollProgress,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.lerp(MoodiColors.hotPink, MoodiColors.neonCyan, _scrollProgress)!,
                ),
                minHeight: 2.5,
              ),
            ),
          ),

          // Theme toggle button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 12,
            child: _buildThemeToggle(isDark),
          ),
        ],
        ),
      ),
      floatingActionButton: AnimatedScale(
        scale: _showFab ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: MoodiColors.neonNightGradient,
            boxShadow: [
              BoxShadow(color: MoodiColors.electricPurple.withAlpha(80), blurRadius: 12, spreadRadius: 1),
            ],
          ),
          child: FloatingActionButton.small(
            onPressed: () {
              _scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeOutCubic);
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(bool isDark) {
    return GestureDetector(
      onTap: widget.onToggleTheme,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withAlpha(20) : Colors.black.withAlpha(10),
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark ? Colors.white.withAlpha(30) : Colors.black.withAlpha(15),
          ),
          boxShadow: [
            BoxShadow(
              color: (isDark ? MoodiColors.electricPurple : const Color(0xFF6200EA)).withAlpha(30),
              blurRadius: 8,
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween(begin: 0.5, end: 1.0).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            key: ValueKey(isDark),
            color: isDark ? MoodiColors.getIconAccent(isDark) : const Color(0xFF6200EA),
            size: 20,
          ),
        ),
      ),
    );
  }
}

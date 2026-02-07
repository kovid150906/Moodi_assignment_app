import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';

class SponsorsSection extends StatelessWidget {
  const SponsorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isDark),
          const SizedBox(height: 14),
          // Responsive sponsor cards layout
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              // Use wrap layout on larger screens
              if (screenWidth >= 800) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AnimationLimiter(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(MoodiData.sponsors.length, (index) {
                        final sponsor = MoodiData.sponsors[index];
                        final isTitle = sponsor.category.toLowerCase().contains('title');
                        final colors = [MoodiColors.getOrangeAccent(isDark), MoodiColors.neonCyan, MoodiColors.hotPink, MoodiColors.limeGreen, MoodiColors.electricPurple, MoodiColors.getAccentColor(isDark), MoodiColors.skyBlue, MoodiColors.getYellowAccent(isDark)];
                        final color = isTitle ? MoodiColors.gold : colors[index % colors.length];
                        final gradients = MoodiColors.sectionGradients;
                        final gradient = gradients[index % gradients.length];

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset: 50,
                            child: FadeInAnimation(
                              child: Container(
                                width: 140,
                                height: 100,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  gradient: isTitle
                                      ? LinearGradient(colors: [MoodiColors.gold.withAlpha(isDark ? 30 : 20), MoodiColors.deepOrange.withAlpha(isDark ? 20 : 10)])
                                      : null,
                                  color: isTitle ? null : (isDark ? MoodiColors.cardDark : MoodiColors.cardLight),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: color.withAlpha(isDark ? 60 : 40)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 28, height: 28,
                                      decoration: BoxDecoration(
                                        gradient: isTitle ? MoodiColors.royalGradient : gradient,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        isTitle ? Icons.star_rounded : Icons.business_rounded,
                                        size: 14, color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      sponsor.name,
                                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: isTitle ? MoodiColors.gold : (isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight)),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      sponsor.category,
                                      style: GoogleFonts.inter(fontSize: 9, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight, fontWeight: FontWeight.w500),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              } else {
                // Horizontal scrolling for smaller screens
                return SizedBox(
                  height: 100,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: MoodiData.sponsors.length,
                      itemBuilder: (context, index) {
                        final sponsor = MoodiData.sponsors[index];
                        final isTitle = sponsor.category.toLowerCase().contains('title');
                        final colors = [MoodiColors.getOrangeAccent(isDark), MoodiColors.neonCyan, MoodiColors.hotPink, MoodiColors.limeGreen, MoodiColors.electricPurple, MoodiColors.getAccentColor(isDark), MoodiColors.skyBlue, MoodiColors.getYellowAccent(isDark)];
                        final color = isTitle ? MoodiColors.gold : colors[index % colors.length];
                        final gradients = MoodiColors.sectionGradients;
                        final gradient = gradients[index % gradients.length];

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset: 50,
                            child: FadeInAnimation(
                              child: Container(
                                width: 140,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  gradient: isTitle
                                      ? LinearGradient(colors: [MoodiColors.gold.withAlpha(isDark ? 30 : 20), MoodiColors.deepOrange.withAlpha(isDark ? 20 : 10)])
                                      : null,
                                  color: isTitle ? null : (isDark ? MoodiColors.cardDark : MoodiColors.cardLight),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: color.withAlpha(isDark ? 60 : 40)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 28, height: 28,
                                      decoration: BoxDecoration(
                                        gradient: isTitle ? MoodiColors.royalGradient : gradient,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        isTitle ? Icons.star_rounded : Icons.business_rounded,
                                        size: 14, color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      sponsor.name,
                                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: isTitle ? MoodiColors.gold : (isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight)),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      sponsor.category,
                                      style: GoogleFonts.inter(fontSize: 9, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight, fontWeight: FontWeight.w500),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
              gradient: MoodiColors.sunsetGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SPONSORS', style: GoogleFonts.anton(fontSize: 22, fontWeight: FontWeight.w400, color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight, letterSpacing: 2)),
              Text('Powered by visionaries', style: GoogleFonts.inter(fontSize: 12, color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight)),
            ],
          ),
        ],
      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
    );
  }
}

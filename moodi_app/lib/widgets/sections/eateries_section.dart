import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';
import '../../models/event_models.dart';

class EateriesSection extends StatefulWidget {
  const EateriesSection({super.key});

  @override
  State<EateriesSection> createState() => _EateriesSectionState();
}

class _EateriesSectionState extends State<EateriesSection> {
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
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: _isExpanded ? _buildEateriesList(isDark) : const SizedBox.shrink(),
          ),
        ],
      ),
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
              width: 4,
              height: 28,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [MoodiColors.limeGreen, MoodiColors.getYellowAccent(isDark)],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HUNGRY? WANNA EAT?',
                  style: GoogleFonts.anton(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  _isExpanded ? 'Tap to collapse' : '12 Eateries on Campus',
                  style: GoogleFonts.workSans(
                    fontSize: 12,
                    color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                  ),
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

  Widget _buildEateriesList(bool isDark) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: MoodiData.canteens.length,
        itemBuilder: (context, index) {
          final canteen = MoodiData.canteens[index];
          return _buildCanteenCard(canteen, isDark, index);
        },
      ),
    );
  }

  Widget _buildCanteenCard(Canteen canteen, bool isDark, int index) {
    final colors = [
      MoodiColors.limeGreen,
      MoodiColors.blazeOrange,
      MoodiColors.neonPink,
      MoodiColors.neonCyan,
    ];
    final accentColor = colors[index % colors.length];

    return GestureDetector(
      onTap: () => _showCanteenDetails(context, canteen, accentColor, isDark),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? MoodiColors.cardDark : MoodiColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withAlpha(50),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor.withAlpha(30),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.restaurant_rounded,
                color: accentColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              canteen.name,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : MoodiColors.textOnLight,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 12,
                  color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    canteen.location,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor.withAlpha(30),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'TAP TO VIEW',
                style: GoogleFonts.bebasNeue(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ).animate(delay: (index * 80).ms).fadeIn(duration: 400.ms).slideX(begin: 0.2),
    );
  }

  void _showCanteenDetails(BuildContext context, canteen, Color accentColor, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.of(ctx).pop(),
        behavior: HitTestBehavior.opaque,
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
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
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withAlpha(60) : Colors.black.withAlpha(30),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [accentColor, accentColor.withAlpha(180)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.restaurant_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                canteen.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : MoodiColors.textOnLight,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: accentColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      canteen.location,
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (canteen.description != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        canteen.description!,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                          height: 1.5,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Text(
                      'MUST TRY',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: accentColor,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildFoodItem(
                      Icons.eco_rounded,
                      'Best Veg',
                      canteen.bestVeg,
                      Colors.green,
                      isDark,
                    ),
                    const SizedBox(height: 10),
                    _buildFoodItem(
                      Icons.restaurant_menu_rounded,
                      'Best Non-Veg',
                      canteen.bestNonVeg,
                      Colors.red,
                      isDark,
                    ),
                    const SizedBox(height: 24),
                    // Website button if available
                    if (canteen.websiteUrl != null) ...[
                      InkWell(
                        onTap: () async {
                          final uri = Uri.parse(canteen.websiteUrl!);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.deepPurple, Colors.deepPurple.shade700],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withAlpha(80),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.open_in_browser_rounded, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'VISIT WEBSITE',
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    InkWell(
                      onTap: () async {
                        final uri = Uri.parse(canteen.mapsUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [accentColor, accentColor.withAlpha(180)],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withAlpha(80),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.directions_rounded, color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'GET DIRECTIONS',
                              style: GoogleFonts.bebasNeue(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
          ),
        ),
      ),
    );
  }

  Widget _buildFoodItem(IconData icon, String label, String food, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                food,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : MoodiColors.textOnLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

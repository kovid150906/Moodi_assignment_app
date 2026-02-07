import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';
import '../../models/event_models.dart';

class ShopsAndSpotsSection extends StatefulWidget {
  const ShopsAndSpotsSection({super.key});

  @override
  State<ShopsAndSpotsSection> createState() => _ShopsAndSpotsSectionState();
}

class _ShopsAndSpotsSectionState extends State<ShopsAndSpotsSection> {
  bool _isShopsExpanded = false;
  bool _isSpotsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shops Section
          _buildShopsHeader(isDark),
          const SizedBox(height: 16),
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: _isShopsExpanded ? _buildShopsList(isDark) : const SizedBox.shrink(),
          ),
          const SizedBox(height: 24),
          // Famous Spots Section
          _buildSpotsHeader(isDark),
          const SizedBox(height: 16),
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: _isSpotsExpanded ? _buildSpotsList(isDark) : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // ==================== SHOPS SECTION ====================
  Widget _buildShopsHeader(bool isDark) {
    return GestureDetector(
      onTap: () => setState(() => _isShopsExpanded = !_isShopsExpanded),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 28,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [MoodiColors.blueViolet, MoodiColors.neonPink],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CAMPUS SHOPS',
                  style: GoogleFonts.anton(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  _isShopsExpanded ? 'Tap to collapse' : '${MoodiData.shops.length} Shops Available',
                  style: GoogleFonts.workSans(
                    fontSize: 12,
                    color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                  ),
                ),
              ],
            ),
            const Spacer(),
            AnimatedRotation(
              turns: _isShopsExpanded ? 0.5 : 0,
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

  Widget _buildShopsList(bool isDark) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: MoodiData.shops.length,
        itemBuilder: (context, index) {
          final shop = MoodiData.shops[index];
          return _buildShopCard(shop, isDark, index);
        },
      ),
    );
  }

  Widget _buildShopCard(Shop shop, bool isDark, int index) {
    final isSouvenir = shop.type == 'Souvenir Shop';
    final accentColor = isSouvenir ? MoodiColors.blazeOrange : MoodiColors.blueViolet;

    return GestureDetector(
      onTap: () => _showShopDetails(shop, accentColor, isDark),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? MoodiColors.cardDark : MoodiColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withAlpha(isSouvenir ? 80 : 50),
            width: isSouvenir ? 2 : 1,
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
                isSouvenir ? Icons.card_giftcard_rounded : Icons.store_rounded,
                color: accentColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              shop.name,
              style: GoogleFonts.poppins(
                fontSize: 14,
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
                  size: 11,
                  color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    shop.location,
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

  void _showShopDetails(Shop shop, Color accentColor, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.of(ctx).pop(),
        behavior: HitTestBehavior.opaque,
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.45,
            maxChildSize: 0.6,
            minChildSize: 0.3,
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withAlpha(60) : Colors.black.withAlpha(30),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: accentColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            shop.type == 'Souvenir Shop' ? Icons.card_giftcard_rounded : Icons.store_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          shop.name,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : MoodiColors.textOnLight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                shop.location,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        if (shop.description != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            shop.description!,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: () async {
                            final uri = Uri.parse(shop.mapsUrl);
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
                        const SizedBox(height: 16),
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

  // ==================== FAMOUS SPOTS SECTION ====================
  Widget _buildSpotsHeader(bool isDark) {
    return GestureDetector(
      onTap: () => setState(() => _isSpotsExpanded = !_isSpotsExpanded),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 28,
              decoration: BoxDecoration(
                gradient: MoodiColors.sunsetGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FAMOUS SPOTS',
                  style: GoogleFonts.anton(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  _isSpotsExpanded ? 'Tap to collapse' : 'Must-visit locations',
                  style: GoogleFonts.workSans(
                    fontSize: 12,
                    color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                  ),
                ),
              ],
            ),
            const Spacer(),
            AnimatedRotation(
              turns: _isSpotsExpanded ? 0.5 : 0,
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

  Widget _buildSpotsList(bool isDark) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: MoodiData.famousSpots.length,
        itemBuilder: (context, index) {
          final spot = MoodiData.famousSpots[index];
          return _buildSpotCard(spot, isDark, index);
        },
      ),
    );
  }

  Widget _buildSpotCard(FamousSpot spot, bool isDark, int index) {
    final colors = [
      MoodiColors.blazeOrange,
      MoodiColors.neonCyan,
      MoodiColors.neonPink,
      MoodiColors.limeGreen,
    ];
    final accentColor = colors[index % colors.length];

    return GestureDetector(
      onTap: () => _showSpotDetails(spot, accentColor, isDark),
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [MoodiColors.cardDark, MoodiColors.elevatedDark]
                : [MoodiColors.cardLight, MoodiColors.elevatedLight],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withAlpha(60),
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accentColor, accentColor.withAlpha(180)],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                spot.icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              spot.name,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : MoodiColors.textOnLight,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                spot.description,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                  height: 1.3,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentColor.withAlpha(80)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.touch_app_rounded, size: 14, color: accentColor),
                    const SizedBox(width: 6),
                    Text(
                      'TAP TO VIEW',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: accentColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate(delay: (index * 80).ms).fadeIn(duration: 400.ms).slideX(begin: 0.2),
    );
  }

  void _showSpotDetails(FamousSpot spot, Color accentColor, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.of(ctx).pop(),
        behavior: HitTestBehavior.opaque,
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.7,
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: isDark ? MoodiColors.surfaceDark : MoodiColors.surfaceLight,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withAlpha(60) : Colors.black.withAlpha(30),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [accentColor, accentColor.withAlpha(180)],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            spot.icon,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          spot.name,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : MoodiColors.textOnLight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withAlpha(10) : Colors.black.withAlpha(5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            spot.description,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: () async {
                            final uri = Uri.parse(spot.mapsUrl);
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
                                const Icon(Icons.directions_rounded, color: Colors.white, size: 22),
                                const SizedBox(width: 10),
                                Text(
                                  'GET DIRECTIONS',
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
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
}

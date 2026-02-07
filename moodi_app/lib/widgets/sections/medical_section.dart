import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';
import '../../models/event_models.dart';

class MedicalSection extends StatefulWidget {
  const MedicalSection({super.key});

  @override
  State<MedicalSection> createState() => _MedicalSectionState();
}

class _MedicalSectionState extends State<MedicalSection> {
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
            child: _isExpanded ? _buildMedicalList(isDark) : const SizedBox.shrink(),
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
                  colors: [Colors.red.shade600, Colors.pink.shade700],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOSPITALS & PHARMACIES',
                  style: GoogleFonts.anton(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  _isExpanded ? 'Tap to collapse' : 'Campus & Nearby Medical Facilities',
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

  Widget _buildMedicalList(bool isDark) {
    final campusFacilities = MoodiData.medicalFacilities.where((f) => !f.isExternal).toList();
    final externalFacilities = MoodiData.medicalFacilities.where((f) => f.isExternal).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // IIT Bombay Facilities
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'ON CAMPUS',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: campusFacilities.length,
            itemBuilder: (context, index) {
              return _buildMedicalCard(campusFacilities[index], isDark, index);
            },
          ),
        ),
        const SizedBox(height: 20),
        // Nearby External Facilities
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'NEARBY',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: externalFacilities.length,
            itemBuilder: (context, index) {
              return _buildMedicalCard(externalFacilities[index], isDark, index);
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildMedicalCard(MedicalFacility facility, bool isDark, int index) {
    final isHospital = facility.type == 'Hospital' || facility.type == 'Emergency';
    final accentColor = facility.isEmergency
        ? Colors.red.shade700
        : (isHospital ? Colors.blue.shade600 : Colors.green.shade600);

    return GestureDetector(
      onTap: () => _showMedicalDetails(facility, accentColor, isDark),
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [MoodiColors.cardDark, MoodiColors.elevatedDark]
                : [MoodiColors.cardLight, MoodiColors.elevatedLight],
          ),
          border: Border.all(color: accentColor.withAlpha(60)),
          boxShadow: [
            BoxShadow(
              color: accentColor.withAlpha(20),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      facility.type == 'Pharmacy'
                          ? Icons.medication_rounded
                          : (facility.isEmergency ? Icons.emergency_rounded : Icons.local_hospital_rounded),
                      color: accentColor,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  if (facility.isExternal)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700.withAlpha(30),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.blue.shade700.withAlpha(80)),
                      ),
                      child: Text(
                        'NEARBY',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                facility.name,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : MoodiColors.textOnLight,
                  height: 1.2,
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
                      facility.location,
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
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: accentColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ).animate(delay: (index * 100).ms).fadeIn(duration: 400.ms).slideX(begin: 0.2),
    );
  }

  void _showMedicalDetails(MedicalFacility facility, Color accentColor, bool isDark) {
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
            minChildSize: 0.4,
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
                            facility.type == 'Pharmacy'
                                ? Icons.medication_rounded
                                : (facility.isEmergency ? Icons.emergency_rounded : Icons.local_hospital_rounded),
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          facility.name,
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
                                facility.location,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        if (facility.isEmergency) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.red.withAlpha(30),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red.withAlpha(80)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.access_time_rounded, color: Colors.red, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'Available 24/7',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: () async {
                            final uri = Uri.parse(facility.mapsUrl);
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
}

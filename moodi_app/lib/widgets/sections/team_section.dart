import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';
import '../../models/event_models.dart';

class TeamSection extends StatefulWidget {
  const TeamSection({super.key});

  @override
  State<TeamSection> createState() => _TeamSectionState();
}

class _TeamSectionState extends State<TeamSection> {
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
            child: _isExpanded ? _buildTeamList(isDark) : const SizedBox.shrink(),
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
                gradient: MoodiColors.fireGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MEET THE TEAM',
                  style: GoogleFonts.anton(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  _isExpanded ? 'Tap to collapse' : 'The people behind Mood Indigo 2025',
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

  Widget _buildTeamList(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: MoodiData.teamMembers.length,
            itemBuilder: (context, index) {
              final member = MoodiData.teamMembers[index];
              final previousRole = index > 0 ? MoodiData.teamMembers[index - 1].role : null;
              final showDepartmentDivider = previousRole != null && previousRole != member.role;
              
              return Row(
                children: [
                  if (showDepartmentDivider) _buildDepartmentDivider(member.role, isDark),
                  _buildTeamCard(member, isDark, index),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDepartmentDivider(String role, bool isDark) {
    final roleColor = _getRoleColor(role, isDark);
    return Container(
      width: 4,
      height: 280,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            roleColor.withAlpha(0),
            roleColor,
            roleColor,
            roleColor.withAlpha(0),
          ],
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Color _getRoleColor(String role, bool isDark) {
    final Map<String, Color> roleColors = {
      'Overall Coordinator': MoodiColors.blazeOrange,
      'Competitions & LYPS': MoodiColors.neonCyan,
      'Creatives': MoodiColors.neonPink,
      'Food & Beverages': MoodiColors.limeGreen,
      'Proshows': MoodiColors.hotPink,
      'Hospitality & PR': MoodiColors.blueViolet,
      'Informals & Workshops': Colors.amber,
      'Marketing': MoodiColors.azureBlue,
      'Media & Publicity': Colors.purple,
      'Operations & Logistics': Colors.teal,
      'Pronites': MoodiColors.electricPurple,
    };
    return roleColors[role] ?? MoodiColors.neonCyan;
  }

  Widget _buildTeamCard(TeamMember member, bool isDark, int index) {
    final accentColor = _getRoleColor(member.role, isDark);

    return GestureDetector(
      onTap: () => _showMemberDetails(member, accentColor, isDark),
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [MoodiColors.cardDark, MoodiColors.elevatedDark]
                : [MoodiColors.cardLight, MoodiColors.elevatedLight],
          ),
          border: Border.all(color: accentColor.withAlpha(100), width: 2),
          boxShadow: [
            BoxShadow(
              color: accentColor.withAlpha(40),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Department Badge at Top
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accentColor, accentColor.withAlpha(200)],
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Text(
                member.role.toUpperCase(),
                style: GoogleFonts.bebasNeue(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Image
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    member.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight,
                        child: Center(
                          child: Icon(
                            Icons.person_rounded,
                            size: 60,
                            color: accentColor.withAlpha(100),
                          ),
                        ),
                      );
                    },
                  ),
                  // Gradient overlay at bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withAlpha(180)],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      member.name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : MoodiColors.textOnLight,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withAlpha(20) : accentColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: isDark ? Colors.white.withAlpha(60) : accentColor.withAlpha(100)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.info_outline, size: 10, color: isDark ? Colors.white : accentColor),
                            const SizedBox(width: 4),
                            Text(
                              'TAP TO VIEW',
                              style: GoogleFonts.bebasNeue(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : accentColor,
                                letterSpacing: 1,
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
          ],
        ),
      ).animate(delay: (index * 20).ms).fadeIn(duration: 200.ms).slideX(begin: 0.1),
    );
  }

  void _showMemberDetails(TeamMember member, Color accentColor, bool isDark) {
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
                    // Profile Image
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: accentColor, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withAlpha(60),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          member.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight,
                              child: Icon(Icons.person_rounded, size: 60, color: accentColor),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      member.name,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : MoodiColors.textOnLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accentColor, accentColor.withAlpha(180)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        member.role,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Contact Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone_rounded, color: accentColor, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  member.phone,
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: isDark ? Colors.white : MoodiColors.textOnLight,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final uri = Uri.parse('tel:${member.phone}');
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: accentColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.call_rounded, color: accentColor, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Social Links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (member.instagram != null)
                          _buildSocialButton(
                            Icons.camera_alt_rounded,
                            'Instagram',
                            'https://instagram.com/${member.instagram}',
                            const Color(0xFFE4405F),
                            isDark,
                          ),
                        if (member.instagram != null && member.linkedin != null)
                          const SizedBox(width: 12),
                        if (member.linkedin != null)
                          _buildSocialButton(
                            Icons.business_center_rounded,
                            'LinkedIn',
                            'https://linkedin.com/in/${member.linkedin}',
                            const Color(0xFF0A66C2),
                            isDark,
                          ),
                      ],
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

  Widget _buildSocialButton(IconData icon, String label, String url, Color color, bool isDark) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withAlpha(60)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colors.dart';
import '../../data/moodi_data.dart';

class ScheduleSection extends StatefulWidget {
  const ScheduleSection({super.key});

  @override
  State<ScheduleSection> createState() => _ScheduleSectionState();
}

class _ScheduleSectionState extends State<ScheduleSection> {
  int _selectedDay = 0;

  final List<Color> dayColors = [
    MoodiColors.neonPink,
    MoodiColors.blazeOrange,
    MoodiColors.blueViolet,
    MoodiColors.azureBlue,
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isDark),
          const SizedBox(height: 16),
          _buildScheduleLayout(isDark),
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
            width: 4,
            height: 28,
            decoration: BoxDecoration(
              gradient: MoodiColors.auroraGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SCHEDULE',
                style: GoogleFonts.spaceMono(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
                  letterSpacing: 3,
                ),
              ),
              Text(
                'December 15-18, 2025',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                ),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.1),
    );
  }

  Widget _buildScheduleLayout(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVerticalDateSelector(isDark),
          const SizedBox(width: 12),
          Expanded(child: _buildEventsList(isDark)),
        ],
      ),
    );
  }

  Widget _buildVerticalDateSelector(bool isDark) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: MoodiData.schedule.asMap().entries.map((entry) {
        final index = entry.key;
        final dayData = entry.value;
        final isSelected = _selectedDay == index;
        final color = dayColors[index % dayColors.length];

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () => setState(() => _selectedDay = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 56,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [color, color.withAlpha(180)],
                      )
                    : null,
                color: isSelected ? null : (isDark ? MoodiColors.cardDark : MoodiColors.cardLight),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? color : (isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: color.withAlpha(80), blurRadius: 12, spreadRadius: 1)]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayData['dayLabel'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    (dayData['date'] as String).split(' ').last,
                    style: GoogleFonts.spaceMono(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight),
                    ),
                  ),
                  Text(
                    'DEC',
                    style: GoogleFonts.inter(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white.withAlpha(200)
                          : (isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms, delay: (index * 80).ms).slideX(begin: -0.2),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEventsList(bool isDark) {
    final dayEvents = MoodiData.schedule[_selectedDay]['events'] as List<Map<String, String>>;
    final dayColor = dayColors[_selectedDay % dayColors.length];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0.1, 0), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
      child: Column(
        key: ValueKey(_selectedDay),
        children: dayEvents.asMap().entries.map((entry) {
          final index = entry.key;
          final event = entry.value;
          final isPronite = (event['title'] ?? '').toUpperCase().contains('PRONITE') ||
              (event['title'] ?? '').toUpperCase().contains('HUMOR FEST');

          return GestureDetector(
            onTap: () => _showEventPopup(context, event, isDark, dayColor),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isPronite
                    ? dayColor.withAlpha(isDark ? 25 : 18)
                    : (isDark ? MoodiColors.cardDark : MoodiColors.cardLight),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isPronite
                      ? dayColor.withAlpha(60)
                      : (isDark ? MoodiColors.elevatedDark : MoodiColors.elevatedLight),
                ),
                boxShadow: isPronite
                    ? [BoxShadow(color: dayColor.withAlpha(30), blurRadius: 8)]
                    : [],
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    decoration: BoxDecoration(
                      color: (isPronite ? dayColor : MoodiColors.azureBlue).withAlpha(20),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      event['time'] ?? '',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spaceMono(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: isPronite ? dayColor : MoodiColors.azureBlue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isPronite ? FontWeight.bold : FontWeight.w500,
                            color: isDark ? Colors.white : MoodiColors.textOnLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 10,
                              color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              event['venue'] ?? '',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isPronite)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: MoodiColors.fireGradient,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'LIVE',
                        style: GoogleFonts.spaceMono(
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    )
                  else
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: isDark ? MoodiColors.textMutedDark : MoodiColors.textMutedLight,
                    ),
                ],
              ),
            ).animate().fadeIn(duration: 350.ms, delay: (index * 50).ms).slideX(begin: 0.08, curve: Curves.easeOut),
          );
        }).toList(),
      ),
    );
  }

  void _showEventPopup(BuildContext context, Map<String, String> event, bool isDark, Color accentColor) {
    final isPronite = (event['title'] ?? '').toUpperCase().contains('PRONITE') ||
        (event['title'] ?? '').toUpperCase().contains('HUMOR FEST');

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withAlpha(150),
      builder: (ctx) => GestureDetector(
        onTap: () => Navigator.of(ctx).pop(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? MoodiColors.cardDark : MoodiColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withAlpha(80), width: 2),
                boxShadow: [
                  BoxShadow(color: accentColor.withAlpha(40), blurRadius: 24, spreadRadius: 4),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: isPronite ? MoodiColors.fireGradient : MoodiColors.oceanGradient,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title'] ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : MoodiColors.textOnLight,
                              ),
                            ),
                            if (isPronite)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  gradient: MoodiColors.fireGradient,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'HEADLINER',
                                  style: GoogleFonts.spaceMono(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _infoRow(Icons.access_time_rounded, event['time'] ?? '', accentColor, isDark),
                  const SizedBox(height: 10),
                  _infoRow(Icons.location_on_rounded, event['venue'] ?? '', accentColor, isDark),
                  const SizedBox(height: 20),
                  Text(
                    _getEventDescription(event['title'] ?? ''),
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isDark ? MoodiColors.textSecondaryDark : MoodiColors.textSecondaryLight,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: MoodiColors.oceanGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'GOT IT',
                          style: GoogleFonts.spaceMono(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms).scale(begin: const Offset(0.9, 0.9)),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, Color color, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? MoodiColors.textOnDark : MoodiColors.textOnLight,
          ),
        ),
      ],
    );
  }

  String _getEventDescription(String title) {
    final descriptions = {
      'Fest Inauguration': 'The grand opening ceremony of Mood Indigo 2025, marking the beginning of Asia\'s largest college cultural festival.',
      'Music Production Workshop': 'Learn digital music production, DAWs, mixing and mastering from Furtados professionals.',
      'Livewire Round 1': 'First round of India\'s biggest college band battle. Bands from across the nation compete.',
      'Cultural Carnival Begins': 'International delegations showcase their culture, food, and art from 5 continents.',
      'Art Competitions': 'Showcase your artistic talents in various competitions including painting, sketching, and digital art.',
      'Street Art Workshop': 'Spray-can graffiti, stencil art, and urban sketching aligned with this year\'s theme.',
      'Livewire Round 2': 'Second round of the band battle. Only the best move forward to the finals.',
      'Improv Night': 'Improvisational comedy where the audience controls the show. Unscripted chaos!',
      'EDM Night': 'High-energy EDM night with top DJs. Laser lights, fog machines, and pure bass.',
      'Dance Competitions': 'Various dance competitions spanning classical, contemporary, and street styles.',
      'World Dance Championship': 'International dance crews compete in styles from K-Pop to Salsa to B-Boying.',
      'Comedy Workshop': 'Craft your first 5-minute stand-up set with guidance from professional comedians.',
      'Livewire Finals': 'The ultimate showdown. India\'s best college bands compete for the crown.',
      'Classical Jugalbandi': 'A mesmerizing evening of Indian classical music featuring tabla, sitar, and vocals.',
      'LitFest Panels': 'Engaging discussions and panels with renowned authors and literary figures.',
      'Photography Walk': 'Explore the beautiful IIT Bombay campus with fellow photography enthusiasts.',
      'Award Ceremonies': 'Celebrating the winners across all competitions and events.',
      'Closing Ceremony': 'The grand finale of Mood Indigo 2025. Farewell until next year!',
    };
    return descriptions[title] ?? 'An exciting event at Mood Indigo 2025. Don\'t miss this!';
  }
}

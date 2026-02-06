import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/colors.dart';

/// Did You Know section with interesting Mood Indigo facts and images
class DidYouKnowSection extends StatefulWidget {
  const DidYouKnowSection({super.key});

  @override
  State<DidYouKnowSection> createState() => _DidYouKnowSectionState();
}

class _DidYouKnowSectionState extends State<DidYouKnowSection> {
  PageController? _pageController;
  int _currentIndex = 0;
  int _lastCardsPerView = 1;
  Timer? _autoScrollTimer;

  // Define colors that adapt to theme
  List<Color> _getFactColors(bool isDark) {
    return [
      MoodiColors.getRedAccent(isDark),
      MoodiColors.getAccentColor(isDark),
      MoodiColors.autumnLeaf,
      MoodiColors.brickEmber,
      MoodiColors.redOchre,
      isDark ? MoodiColors.blackCherry : Color(0xFF8B0000),
      MoodiColors.getOrangeAccent(isDark),
      MoodiColors.getYellowAccent(isDark),
    ];
  }

  static const List<MoodiFact> facts = [
    MoodiFact(
      title: 'Named After Jazz',
      fact: 'Mood Indigo is named after Duke Ellington\'s famous 1930 jazz composition!',
      icon: Icons.music_note_rounded,
      color: Color(0xFF9D0208), // Will be replaced dynamically
      imageUrl: 'https://images.unsplash.com/photo-1511192336575-5a79af67a629?w=600',
    ),
    MoodiFact(
      title: 'Started With Rs. 5,000',
      fact: 'The first Mood Indigo in 1971 had a budget of just Rs. 5,000. Now it\'s multi-crore!',
      icon: Icons.currency_rupee_rounded,
      color: Color(0xFFF48C06), // Will be replaced dynamically
      imageUrl: 'https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=600',
    ),
    MoodiFact(
      title: 'Asia\'s Largest',
      fact: 'MI is Asia\'s largest college cultural fest with 4,000+ colleges from 50+ countries!',
      icon: Icons.emoji_events_rounded,
      color: Color(0xFFE85D04), // Will be replaced dynamically
      imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=600',
    ),
    MoodiFact(
      title: 'World Record Holder',
      fact: 'MI holds the Limca Book record for most international artists at a college fest!',
      icon: Icons.public_rounded,
      color: Color(0xFFD00000), // Will be replaced dynamically
      imageUrl: 'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=600',
    ),
    MoodiFact(
      title: 'First International Night',
      fact: 'Finnish metal band Ensiferum performed in 2008, marking MI\'s global expansion!',
      icon: Icons.flight_takeoff_rounded,
      color: Color(0xFFDC2F02), // Will be replaced dynamically
      imageUrl: 'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?w=600',
    ),
    MoodiFact(
      title: '240+ Events',
      fact: 'With over 240 events across 4 days, MI runs non-stop from workshops to pronites!',
      icon: Icons.schedule_rounded,
      color: Color(0xFF6A040F), // Will be replaced dynamically
      imageUrl: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=600',
    ),
    MoodiFact(
      title: 'Legendary Performers',
      fact: 'Porcupine Tree, Simple Plan, R.D. Burman, A.R. Rahman have graced the MI stage!',
      icon: Icons.star_rounded,
      color: Color(0xFFFAA307), // Will be replaced dynamically
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=600',
    ),
    MoodiFact(
      title: 'Student Volunteers',
      fact: 'Entirely organized by students with no profit motive - all for the love of culture!',
      icon: Icons.volunteer_activism_rounded,
      color: Color(0xFFFFBA08), // Will be replaced dynamically
      imageUrl: 'https://images.unsplash.com/photo-1523580494863-6f3031224c94?w=600',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Controller will be initialized in build
  }
  
  void _initializeController(int cardsPerView) {
    if (_lastCardsPerView == cardsPerView && _pageController != null) return;
    
    _stopAutoScroll();
    _pageController?.dispose();
    
    _pageController = PageController();
    _currentIndex = 0;
    _lastCardsPerView = cardsPerView;
    _startAutoScroll(cardsPerView);
  }

  void _startAutoScroll(int cardsPerView) {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || _pageController == null || !_pageController!.hasClients) return;
      final totalPages = cardsPerView == 1 ? facts.length : (facts.length / cardsPerView).ceil();
      final nextIndex = (_currentIndex + 1) % totalPages;
      _pageController!.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
  
  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        MoodiColors.getAccentColor(isDark),
                        isDark ? MoodiColors.autumnLeaf : const Color(0xFFB84000),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: MoodiColors.getAccentColor(isDark).withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lightbulb_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DID YOU KNOW?',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          color: isDark
                              ? MoodiColors.textOnDark
                              : MoodiColors.textOnLight,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Fun facts about Mood Indigo',
                        style: GoogleFonts.workSans(
                          fontSize: 13,
                          color: isDark
                              ? MoodiColors.textMutedDark
                              : MoodiColors.textMutedLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 28),
          
          // Fact Cards Carousel with Images
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              // Determine cards per view based on width
              int cardsPerView = 1;
              if (screenWidth >= 1400) {
                cardsPerView = 4;
              } else if (screenWidth >= 1000) {
                cardsPerView = 3;
              } else if (screenWidth >= 700) {
                cardsPerView = 2;
              }
              
              // Initialize controller with current layout
              _initializeController(cardsPerView);
              
              if (_pageController == null) return const SizedBox();
              
              return SizedBox(
                height: 290,
                child: cardsPerView == 1
                    ? PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => _currentIndex = index);
                        },
                        itemCount: facts.length,
                        itemBuilder: (context, index) {
                          final fact = facts[index];
                          final colors = _getFactColors(isDark);
                          return _FactCard(fact: fact, isDark: isDark, accentColor: colors[index]);
                        },
                      )
                    : PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() => _currentIndex = index);
                        },
                        itemCount: (facts.length / cardsPerView).ceil(),
                        itemBuilder: (context, pageIndex) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: List.generate(cardsPerView, (cardIndex) {
                                final actualIndex = (pageIndex * cardsPerView) + cardIndex;
                                if (actualIndex >= facts.length) {
                                  return Expanded(child: SizedBox());
                                }
                                final fact = facts[actualIndex];
                                final colors = _getFactColors(isDark);
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: cardIndex == 0 ? 0 : (cardIndex == cardsPerView - 1 ? 0 : 4),
                                    ),
                                    child: _FactCard(fact: fact, isDark: isDark, accentColor: colors[actualIndex]),
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // Page Indicators
          LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              int cardsPerView = 1;
              if (screenWidth >= 1400) {
                cardsPerView = 4;
              } else if (screenWidth >= 1000) {
                cardsPerView = 3;
              } else if (screenWidth >= 700) {
                cardsPerView = 2;
              }
              final totalPages = cardsPerView == 1 ? facts.length : (facts.length / cardsPerView).ceil();
              
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (index) {
                  final isActive = index == _currentIndex;
                  final colors = _getFactColors(isDark);
                  final colorIndex = cardsPerView == 1 ? _currentIndex : (_currentIndex * cardsPerView).clamp(0, colors.length - 1);
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? colors[colorIndex]
                          : (isDark
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.black.withValues(alpha: 0.1)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}

class _FactCard extends StatelessWidget {
  final MoodiFact fact;
  final bool isDark;
  final Color accentColor;

  const _FactCard({required this.fact, required this.isDark, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: isDark ? 0.2 : 0.15),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            CachedNetworkImage(
              imageUrl: fact.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: isDark ? MoodiColors.cardDark : MoodiColors.cardLight,
                child: Center(
                  child: CircularProgressIndicator(
                    color: accentColor,
                    strokeWidth: 2,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: isDark ? MoodiColors.cardDark : MoodiColors.cardLight,
                child: Icon(fact.icon, size: 60, color: fact.color.withValues(alpha: 0.3)),
              ),
            ),
            
            // Gradient overlay for text readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.5),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon badge at top
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      fact.icon,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Title with colored accent
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          fact.title,
                          style: GoogleFonts.rajdhani(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.5),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Fact text
                  Text(
                    fact.fact,
                    style: GoogleFonts.workSans(
                      fontSize: 15,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.95),
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data model for a Mood Indigo fact
class MoodiFact {
  final String title;
  final String fact;
  final IconData icon;
  final Color color;
  final String imageUrl;

  const MoodiFact({
    required this.title,
    required this.fact,
    required this.icon,
    required this.color,
    required this.imageUrl,
  });
}

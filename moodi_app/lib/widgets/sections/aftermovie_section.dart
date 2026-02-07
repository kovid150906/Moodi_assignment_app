import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../theme/colors.dart';

class AftermovieSection extends StatefulWidget {
  const AftermovieSection({super.key});

  @override
  State<AftermovieSection> createState() => _AftermovieSectionState();
}

class _AftermovieSectionState extends State<AftermovieSection> {
  bool _isExpanded = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'WeKGUKuqWaY',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
        hideControls: false,
        controlsVisibleAtStart: true,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive breakpoints
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    
    // Responsive values
    final maxWidth = isDesktop ? 900.0 : (isTablet ? 700.0 : double.infinity);
    final horizontalPadding = isMobile ? 16.0 : (isTablet ? 32.0 : 48.0);
    final titleFontSize = isMobile ? 14.0 : (isTablet ? 16.0 : 18.0);
    final subtitleFontSize = isMobile ? 11.0 : (isTablet ? 12.0 : 13.0);
    final iconSize = isMobile ? 20.0 : 24.0;
    final expandIconSize = isMobile ? 24.0 : 28.0;
    final cardPadding = isMobile ? 16.0 : 20.0;
    
    return SliverToBoxAdapter(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                // Collapsible header
                InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                  if (!_isExpanded) {
                    _controller.pause();
                  }
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: cardPadding,
                  vertical: isMobile ? 14.0 : 16.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark 
                        ? [
                            MoodiColors.electricPurple.withAlpha(30),
                            MoodiColors.neonCyan.withAlpha(20),
                          ]
                        : [
                            MoodiColors.hotPink.withAlpha(20),
                            MoodiColors.darkOrange.withAlpha(15),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark 
                        ? MoodiColors.electricPurple.withAlpha(40)
                        : MoodiColors.hotPink.withAlpha(30),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? MoodiColors.electricPurple : MoodiColors.hotPink)
                          .withAlpha(20),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Play icon
                    Container(
                      padding: EdgeInsets.all(isMobile ? 8.0 : 10.0),
                      decoration: BoxDecoration(
                        gradient: MoodiColors.fireGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: MoodiColors.hotPink.withAlpha(60),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isExpanded ? Icons.play_circle_filled : Icons.movie_rounded,
                        color: Colors.white,
                        size: iconSize,
                      ),
                    ),
                    SizedBox(width: isMobile ? 12.0 : 16.0),
                    // Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MOOD INDIGO AFTERMOVIE',
                            style: GoogleFonts.poppins(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = LinearGradient(
                                  colors: isDark
                                      ? [MoodiColors.neonCyan, MoodiColors.electricPurple]
                                      : [MoodiColors.hotPink, MoodiColors.darkOrange],
                                ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _isExpanded ? 'Tap to collapse' : 'Tap to watch',
                            style: GoogleFonts.inter(
                              fontSize: subtitleFontSize,
                              color: isDark 
                                  ? Colors.white.withAlpha(150)
                                  : Colors.black.withAlpha(150),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Expand/collapse icon
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: isDark 
                            ? MoodiColors.neonCyan
                            : MoodiColors.hotPink,
                        size: expandIconSize,
                      ),
                    ),
                  ],
                ),
              ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                
                // Expandable video player
                AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: _isExpanded
                      ? Container(
                      margin: EdgeInsets.only(top: isMobile ? 12.0 : 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(isMobile ? 12.0 : 16.0),
                        boxShadow: [
                          BoxShadow(
                            color: (isDark ? MoodiColors.electricPurple : MoodiColors.hotPink)
                                .withAlpha(30),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(isMobile ? 12.0 : 16.0),
                        child: YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: MoodiColors.hotPink,
                          progressColors: ProgressBarColors(
                            playedColor: MoodiColors.hotPink,
                            handleColor: MoodiColors.neonCyan,
                          ),
                        ),
                      ),
                    )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

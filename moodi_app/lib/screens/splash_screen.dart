import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../theme/colors.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _writeController;
  late AnimationController _fadeController;
  late AnimationController _glowController;
  late Animation<double> _writeAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // Controller for writing effect
    _writeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Controller for fade in of other elements
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Controller for glow effect
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _writeAnimation = CurvedAnimation(
      parent: _writeController,
      curve: Curves.easeInOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _glowAnimation = CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    );

    // Start the animation sequence
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Start writing animation
    await Future.delayed(const Duration(milliseconds: 300));
    _writeController.forward();

    // Fade in subtitle after writing starts
    await Future.delayed(const Duration(milliseconds: 1200));
    _fadeController.forward();

    // Glow effect
    await Future.delayed(const Duration(milliseconds: 500));
    _glowController.forward();

    // Wait a bit before transitioning
    await Future.delayed(const Duration(milliseconds: 1200));
    widget.onComplete();
  }

  @override
  void dispose() {
    _writeController.dispose();
    _fadeController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [
              Color(0xFF000000),
              Color(0xFF0A0001),
              Color(0xFF1A0003),
              Color(0xFF2D0005),
              Color(0xFF1A0003),
              Color(0xFF000000),
            ],
            stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Floating gradient orbs for depth
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      MoodiColors.brickEmber.withAlpha(51),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      MoodiColors.darkOrange.withAlpha(38),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo if available
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: MoodiColors.brickEmber.withAlpha(102),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/moodi_logo.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.celebration_rounded,
                          size: 40,
                          color: MoodiColors.brickEmber,
                        ),
                      ),
                    ),
                  ),
                  // Animated writing text
                  AnimatedBuilder(
                    animation: _writeAnimation,
                    builder: (context, child) {
                      return AnimatedBuilder(
                        animation: _glowAnimation,
                        builder: (context, _) {
                          return ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                colors: [
                                  MoodiColors.brickEmber,
                                  MoodiColors.darkOrange,
                                  MoodiColors.amberFlame,
                                ],
                              ).createShader(bounds);
                            },
                            child: Text(
                              'MOOD INDIGO',
                              style: GoogleFonts.bebasNeue(
                                fontSize: 48,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 8,
                                shadows: [
                                  Shadow(
                                    color: MoodiColors.brickEmber
                                        .withAlpha(((_glowAnimation.value * 0.8) * 255).toInt()),
                                    blurRadius: 20 * _glowAnimation.value,
                                  ),
                                  Shadow(
                                    color: MoodiColors.amberFlame
                                        .withAlpha(((_glowAnimation.value * 0.6) * 255).toInt()),
                                    blurRadius: 40 * _glowAnimation.value,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  // Animated writing line under text
                  AnimatedBuilder(
                    animation: _writeAnimation,
                    builder: (context, child) {
                      return Container(
                        width: 300 * _writeAnimation.value,
                        height: 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MoodiColors.brickEmber,
                              MoodiColors.darkOrange,
                              MoodiColors.amberFlame,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: MoodiColors.darkOrange.withAlpha(128),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Subtitle with fade
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: MoodiColors.fireGradient,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '2025',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'A Vortex of Vandalism',
                          style: GoogleFonts.workSans(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: MoodiColors.textMutedDark,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Loading indicator
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              MoodiColors.amberFlame,
                            ),
                          ),
                        ),
                      ],
                    ),
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

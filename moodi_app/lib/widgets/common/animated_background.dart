import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

/// Smooth animated background with floating gradient blobs
/// Optimized for performance - uses only a few large shapes
class AnimatedBackground extends StatefulWidget {
  final bool isDark;
  
  const AnimatedBackground({super.key, required this.isDark});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;
  final int _blobCount = 5; // Keep it minimal for performance

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = [];
    _animations = [];

    final random = Random(42); // Fixed seed for consistent animation

    for (int i = 0; i < _blobCount; i++) {
      // Create controller with different durations for organic movement
      final controller = AnimationController(
        duration: Duration(seconds: 15 + random.nextInt(15)), // 15-30 seconds
        vsync: this,
      );

      // Random start and end positions
      final startX = random.nextDouble() * 2 - 0.5; // -0.5 to 1.5
      final startY = random.nextDouble() * 2 - 0.5;
      final endX = random.nextDouble() * 2 - 0.5;
      final endY = random.nextDouble() * 2 - 0.5;

      final animation = Tween<Offset>(
        begin: Offset(startX, startY),
        end: Offset(endX, endY),
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutSine,
      ));

      _controllers.add(controller);
      _animations.add(animation);

      controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Blob 1 - Large red-orange
        _buildAnimatedBlob(
          size: size,
          animation: _animations[0],
          colors: widget.isDark
              ? [Color(0xFF9D0208), Color(0xFFDC2F02)]
              : [Color(0xFFFFE5D9), Color(0xFFFFD4B8)],
          scale: 2.5,
          blur: 120,
        ),
        // Blob 2 - Medium orange
        _buildAnimatedBlob(
          size: size,
          animation: _animations[1],
          colors: widget.isDark
              ? [Color(0xFFE85D04), Color(0xFFF48C06)]
              : [Color(0xFFFFE8D6), Color(0xFFFFF0E0)],
          scale: 2.0,
          blur: 100,
        ),
        // Blob 3 - Golden
        _buildAnimatedBlob(
          size: size,
          animation: _animations[2],
          colors: widget.isDark
              ? [Color(0xFFFAA307), Color(0xFFFFBA08)]
              : [Color(0xFFFFF5E6), Color(0xFFFFFBF0)],
          scale: 1.8,
          blur: 90,
        ),
        // Blob 4 - Deep red
        _buildAnimatedBlob(
          size: size,
          animation: _animations[3],
          colors: widget.isDark
              ? [Color(0xFF370617), Color(0xFF6A040F)]
              : [Color(0xFFFFE0E6), Color(0xFFFFEDF0)],
          scale: 2.2,
          blur: 110,
        ),
        // Blob 5 - Dark accent
        _buildAnimatedBlob(
          size: size,
          animation: _animations[4],
          colors: widget.isDark
              ? [Color(0xFF03071E), Color(0xFF370617)]
              : [Color(0xFFFFF9F5), Color(0xFFFFFBF8)],
          scale: 2.3,
          blur: 100,
        ),
      ],
    );
  }

  Widget _buildAnimatedBlob({
    required Size size,
    required Animation<Offset> animation,
    required List<Color> colors,
    required double scale,
    required double blur,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // Calculate position based on animation value
        final offset = animation.value;
        final left = size.width * offset.dx;
        final top = size.height * offset.dy;

        return Positioned(
          left: left,
          top: top,
          child: Container(
            width: size.width * scale,
            height: size.width * scale, // Use width for both to keep it circular
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  colors[0].withAlpha(widget.isDark ? 38 : 64),
                  colors[1].withAlpha(widget.isDark ? 20 : 38),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Simpler version without blur for even better performance
class AnimatedBackgroundSimple extends StatefulWidget {
  final bool isDark;
  
  const AnimatedBackgroundSimple({super.key, required this.isDark});

  @override
  State<AnimatedBackgroundSimple> createState() => _AnimatedBackgroundSimpleState();
}

class _AnimatedBackgroundSimpleState extends State<AnimatedBackgroundSimple>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;
  final int _blobCount = 6;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = [];
    _animations = [];

    final random = Random(42);

    for (int i = 0; i < _blobCount; i++) {
      final controller = AnimationController(
        duration: Duration(seconds: 20 + random.nextInt(20)), // 20-40 seconds
        vsync: this,
      );

      final startX = random.nextDouble() * 2 - 0.5;
      final startY = random.nextDouble() * 2 - 0.5;
      final endX = random.nextDouble() * 2 - 0.5;
      final endY = random.nextDouble() * 2 - 0.5;

      final animation = Tween<Offset>(
        begin: Offset(startX, startY),
        end: Offset(endX, endY),
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutSine,
      ));

      _controllers.add(controller);
      _animations.add(animation);

      controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: List.generate(_blobCount, (index) {
        final colors = _getBlobColors(index);
        final scale = 1.5 + (index * 0.2);
        
        return _buildAnimatedBlob(
          size: size,
          animation: _animations[index],
          colors: colors,
          scale: scale,
        );
      }),
    );
  }

  List<Color> _getBlobColors(int index) {
    final darkColors = [
      [Color(0xFF9D0208), Color(0xFFDC2F02)],
      [Color(0xFFE85D04), Color(0xFFF48C06)],
      [Color(0xFFFAA307), Color(0xFFFFBA08)],
      [Color(0xFF370617), Color(0xFF6A040F)],
      [Color(0xFFDC2F02), Color(0xFFE85D04)],
      [Color(0xFF6A040F), Color(0xFF9D0208)],
    ];

    final lightColors = [
      [Color(0xFFFFE5D9), Color(0xFFFFD4B8)],
      [Color(0xFFFFE8D6), Color(0xFFFFF0E0)],
      [Color(0xFFFFF5E6), Color(0xFFFFFBF0)],
      [Color(0xFFFFE0E6), Color(0xFFFFEDF0)],
      [Color(0xFFFFD9CC), Color(0xFFFFE8D6)],
      [Color(0xFFFFEDF0), Color(0xFFFFF5E6)],
    ];

    return widget.isDark ? darkColors[index] : lightColors[index];
  }

  Widget _buildAnimatedBlob({
    required Size size,
    required Animation<Offset> animation,
    required List<Color> colors,
    required double scale,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final offset = animation.value;
        final left = size.width * offset.dx;
        final top = size.height * offset.dy;

        return Positioned(
          left: left,
          top: top,
          child: Container(
            width: size.width * scale,
            height: size.width * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  colors[0].withAlpha(widget.isDark ? 31 : 51),
                  colors[1].withAlpha(widget.isDark ? 15 : 31),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        );
      },
    );
  }
}

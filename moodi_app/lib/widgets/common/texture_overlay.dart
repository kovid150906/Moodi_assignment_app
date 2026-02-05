import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Adds a rough paper/concrete texture overlay to backgrounds
class TextureOverlay extends StatelessWidget {
  final double opacity;
  
  const TextureOverlay({super.key, this.opacity = 0.08});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: RoughTexturePainter(opacity: opacity),
        ),
      ),
    );
  }
}

class RoughTexturePainter extends CustomPainter {
  final double opacity;
  
  RoughTexturePainter({required this.opacity});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = math.Random(42); // Fixed seed for consistent pattern
    
    // Create multi-layered rough texture
    // Layer 1: Large grain (concrete/paper texture)
    for (int i = 0; i < (size.width * size.height / 30).toInt(); i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final brightness = random.nextDouble();
      final grainSize = random.nextDouble() * 3 + 1;
      
      paint.color = Color.fromRGBO(
        (brightness * 255).toInt(),
        (brightness * 255).toInt(),
        (brightness * 255).toInt(),
        opacity * 0.6,
      );
      
      canvas.drawCircle(Offset(x, y), grainSize, paint);
    }
    
    // Layer 2: Medium grain
    for (int i = 0; i < (size.width * size.height / 80).toInt(); i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final brightness = random.nextDouble() * 0.5;
      
      paint.color = Color.fromRGBO(
        (brightness * 255).toInt(),
        (brightness * 255).toInt(),
        (brightness * 255).toInt(),
        opacity * 0.8,
      );
      
      canvas.drawCircle(Offset(x, y), 1.5, paint);
    }
    
    // Layer 3: Fine grain (paper fibers)
    for (int i = 0; i < (size.width * size.height / 50).toInt(); i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final brightness = random.nextDouble() * 0.3 + 0.7;
      
      paint.color = Color.fromRGBO(
        (brightness * 255).toInt(),
        (brightness * 255).toInt(),
        (brightness * 255).toInt(),
        opacity * 1.2,
      );
      
      // Draw small irregular shapes instead of perfect circles
      final path = Path();
      path.moveTo(x, y);
      path.lineTo(x + random.nextDouble() * 2 - 1, y + random.nextDouble() * 2 - 1);
      path.lineTo(x + random.nextDouble() * 2 - 1, y + random.nextDouble() * 2 - 1);
      path.close();
      canvas.drawPath(path, paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Geometric pattern overlay for sections
class GeometricPattern extends StatelessWidget {
  final Color color;
  final double opacity;
  
  const GeometricPattern({
    super.key,
    required this.color,
    this.opacity = 0.05,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: GeometricPainter(color: color, opacity: opacity),
        ),
      ),
    );
  }
}

class GeometricPainter extends CustomPainter {
  final Color color;
  final double opacity;
  
  GeometricPainter({required this.color, required this.opacity});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    // Draw diamond grid pattern
    final spacing = 80.0;
    for (double x = -spacing; x < size.width + spacing; x += spacing) {
      for (double y = -spacing; y < size.height + spacing; y += spacing) {
        final path = Path()
          ..moveTo(x, y - 30)
          ..lineTo(x + 30, y)
          ..lineTo(x, y + 30)
          ..lineTo(x - 30, y)
          ..close();
        canvas.drawPath(path, paint);
      }
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

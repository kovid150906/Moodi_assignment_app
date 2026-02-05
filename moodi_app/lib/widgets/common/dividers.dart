import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class SectionDivider extends StatelessWidget {
  final double height;
  const SectionDivider({super.key, this.height = 24});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: height));
  }
}

class GradientDivider extends StatelessWidget {
  final LinearGradient gradient;
  const GradientDivider({super.key, this.gradient = MoodiColors.neonNightGradient});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        child: Container(
          height: 1.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                gradient.colors.first.withAlpha(100),
                gradient.colors.last.withAlpha(100),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

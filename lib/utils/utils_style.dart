import 'dart:ui';

class OverlayEffect {
  final Color color;
  final double value;
  const OverlayEffect({required this.color, required this.value});
  Color get finalColor => color.withValues(alpha: value);
}

import "package:flutter/material.dart" show Color;

extension ColorAlphaExtension on Color {
  Color withAlphaPercent(double percent) {
    assert(percent >= 0 && percent <= 100);
    return withValues(alpha: percent / 100);
  }
}
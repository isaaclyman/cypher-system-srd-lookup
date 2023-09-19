import 'package:flutter/material.dart';

class CThemeColors {
  final Color primary = Colors.blue[900]!;
  final Color primaryContrast = Colors.white;
  final Color accent = Colors.pink[900]!;
  final Color accentContrast = Colors.white;
  final Color muted = Colors.grey[600]!;
  final Color mutedContrast = Colors.white;
  final Color text = Colors.black87;
}

final cThemeColors = CThemeColors();

extension CThemeColorsEx on BuildContext {
  CThemeColors get colors => cThemeColors;
}

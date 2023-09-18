import 'package:flutter/material.dart';

class CThemeColors {
  final Color primary = Colors.blue[900]!;
}

final cThemeColors = CThemeColors();

extension CThemeColorsEx on BuildContext {
  CThemeColors get colors => cThemeColors;
}

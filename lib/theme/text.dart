import 'package:flutter/material.dart';

class CThemeText {
  final TextStyle tiny = const TextStyle(
    fontSize: 8,
  );
}

final cThemeText = CThemeText();

extension CThemeTextEx on BuildContext {
  CThemeText get text => cThemeText;
}

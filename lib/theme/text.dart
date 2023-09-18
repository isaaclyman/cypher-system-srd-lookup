import 'package:flutter/material.dart';

class CThemeText {
  final TextStyle highlight = const TextStyle(
    backgroundColor: Colors.yellow,
  );

  final TextStyle legal = const TextStyle(
    fontSize: 8,
  );

  final TextStyle small = const TextStyle(
    fontSize: 10,
  );

  final TextStyle categoryHeader = TextStyle(
    color: Colors.grey[600],
    fontSize: 12,
  );

  final TextStyle resultHeader = TextStyle(
    color: Colors.pink[900],
    fontSize: 16,
  );
}

final cThemeText = CThemeText();

extension CThemeTextEx on BuildContext {
  CThemeText get text => cThemeText;
}

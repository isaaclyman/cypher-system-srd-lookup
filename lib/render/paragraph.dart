import 'package:flutter/material.dart';

class CRenderParagraph extends StatelessWidget {
  final String text;

  const CRenderParagraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

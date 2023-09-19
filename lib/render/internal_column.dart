import 'package:flutter/material.dart';

class CRenderInternalColumn extends StatelessWidget {
  final List<Widget> children;

  const CRenderInternalColumn({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .map(
            (child) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: child,
            ),
          )
          .toList(),
    );
  }
}

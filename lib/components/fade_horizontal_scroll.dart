import 'package:flutter/material.dart';

class CFadeHorizontalScroll extends StatelessWidget {
  final Widget child;

  const CFadeHorizontalScroll({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: ShaderMask(
        shaderCallback: (rect) => const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white,
            Colors.transparent,
            Colors.transparent,
            Colors.white
          ],
          stops: [0.0, 0.02, 0.9, 1.0],
        ).createShader(rect),
        blendMode: BlendMode.dstOut,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

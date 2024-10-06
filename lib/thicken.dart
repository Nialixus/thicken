library thicken;

import 'package:flutter/material.dart';

class Thicken extends StatelessWidget {
  const Thicken({
    super.key,
    this.thickness = 0.15,
    required this.child,
  });
  final double thickness;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int x = 0; x < 3; x++)
            for (int y = 0; y < 3; y++)
              Transform.translate(
                offset: Offset(
                  [-1, -0.5, 0, 0.5, 1][x] * thickness,
                  [-1, -0.5, 0, 0.5, 1][y] * thickness,
                ),
                child: Center(child: child),
              ),
        ],
      ),
    );
  }
}

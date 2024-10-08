/// The [Thicken] widget allows you to thicken a given child widget by creating
/// multiple translated layers of the child. The amount of thickness determines
/// how many layers will be drawn.
///
/// The widget is useful when you want to create a "thick" visual effect by
/// duplicating the child widget with slight offsets.
///
/// Example usage:
/// ```dart
/// Thicken(
///   thickness: 5.0,
///   child: Text(
///     'Thickened Text',
///     style: TextStyle(fontSize: 24),
///   ),
/// )
/// ```
library thicken;

import 'package:flutter/material.dart';

/// A widget that creates a thick visual effect by stacking multiple
/// layers of a given [child] widget with slight translations based on the
/// [thickness] value.
///
/// The number of layers is calculated based on the thickness.
///
/// The higher the thickness value, the more layers will be created, giving
/// the illusion of depth and thickness.
///
/// Example usage:
/// ```dart
/// Thicken(
///   thickness: 3.0,
///   child: Icon(
///     Icons.star,
///     size: 50,
///   ),
/// )
/// ```
///
/// [thickness] : The amount of thickness to apply to the child. Higher values
/// will create more layers.
/// _**(It is not recommended to set thickness greater than 1.0)**_
///
/// [child] : The widget that will be "thickened" by drawing multiple layers.
class Thicken extends StatelessWidget {
  /// Creates a [Thicken] widget.
  ///
  /// The [thickness] parameter defines how many layers of the child widget
  /// will be drawn, and the [child] is the widget that will be stacked with
  /// offset translations.
  const Thicken({
    super.key,
    required this.thickness,
    required this.child,
  });

  /// The amount of thickness applied. The thickness controls how many layers
  /// of the [child] widget are created. A higher [thickness] value creates more
  /// layers and larger translations between them.
  /// _**(It is not recommended to set thickness greater than 1.0)**_
  final double thickness;

  /// The child widget that will be thickened with multiple layers.
  final Widget child;

  /// The number of layers calculated based on the [thickness] value.
  ///
  /// This gives a base of 3 layers, and adds more layers as the thickness
  /// increases.
  int get layers {
    int range = thickness.floor();
    return 3 + (range * 2);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: List.generate(layers * layers, (index) {
        final indexX = index % layers;
        final indexY = index ~/ layers;
        final offsetX = (1 - (2 * indexX / layers)) * thickness;
        final offsetY = (1 - (2 * indexY / layers)) * thickness;

        return Transform.translate(
          offset: Offset(offsetX, offsetY),
          child: child,
        );
      }),
    );
  }
}

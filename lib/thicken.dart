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

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
///   pixelRatio: 10.0,
///   thickness: 3.0,
///   child: Icon(
///     Icons.star,
///     size: 50,
///   ),
/// )
/// ```
///
/// [pixelRatio] : Is the sharpness quality of the stroke.
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
  /// will be drawn, as the [pixelRatio] parameter is used to define the sharpness of the strokes,
  /// and the [child] is the widget that will be thickened.
  Thicken({
    super.key,
    this.pixelRatio = 1.0,
    required this.thickness,
    required this.child,
  });

  /// The key used to convert the [child] widget to an image.
  late final _key = GlobalKey(debugLabel: 'thicken.$key');

  /// The amount of thickness applied. The thickness controls how many layers
  /// of the [child] widget are created. A higher [thickness] value creates more
  /// layers and larger translations between them.
  /// _**(It is not recommended to set thickness greater than 1.0)**_
  final double thickness;

  /// The child widget that will be thickened with multiple layers.
  final Widget child;

  /// The sharpness quality of the strokes used to create the thickening effect.
  /// The bigger the value, the smoother the strokes will be and the more
  /// resources will be used.
  final double pixelRatio;

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
    return FutureBuilder(
      future: () async {
        try {
          // Wait until after the frame is built
          await Future.delayed(Duration.zero);

          final boundary = _key.currentContext?.findRenderObject();
          if (boundary is RenderRepaintBoundary) {
            final image = await boundary.toImage(pixelRatio: pixelRatio);
            final byte = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );

            return byte?.buffer.asUint8List();
          }

          return null;
        } catch (e) {
          return null;
        }
      }(),
      builder: (builder, snapshot) {
        return Stack(
          children: [
            ...List.generate(
              layers * layers,
              (index) {
                final indexX = index % layers;
                final indexY = index ~/ layers;
                final offsetX = (1 - (2 * indexX / layers)) * thickness;
                final offsetY = (1 - (2 * indexY / layers)) * thickness;

                if (index + indexY == 0) return const SizedBox();
                return Positioned.fill(
                  child: Transform.translate(
                    offset: Offset(offsetX, offsetY),
                    child: snapshot.data != null
                        ? Image.memory(snapshot.data!)
                        : child,
                  ),
                );
              },
            ),
            RepaintBoundary(
              key: _key,
              child: child,
            ),
          ],
        );
      },
    );
  }
}

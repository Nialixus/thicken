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
import 'package:flutter/services.dart';
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
class Thicken extends StatefulWidget {
  /// Creates a [Thicken] widget.
  ///
  /// The [thickness] parameter defines how many layers of the child widget
  /// will be drawn, as the [pixelRatio] parameter is used to define the sharpness of the strokes,
  /// and the [child] is the widget that will be thickened.
  const Thicken({
    super.key,
    this.pixelRatio = 2.0,
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
  State<Thicken> createState() => _ThickenState();
}

class _ThickenState extends State<Thicken> {
  @override
  Widget build(BuildContext context) {
    if (widget.thickness == 0.0) return child;
    return Stack(
      children: [
        if (image != null)
          ...List.generate(
            widget.layers * widget.layers,
            (index) {
              final indexX = index % widget.layers;
              final indexY = index ~/ widget.layers;
              final offsetX =
                  (1 - (2 * indexX / widget.layers)) * widget.thickness;
              final offsetY =
                  (1 - (2 * indexY / widget.layers)) * widget.thickness;

              if (index + indexY == 0) return const SizedBox();
              return Positioned.fill(
                child: Transform.translate(
                    offset: Offset(offsetX, offsetY),
                    child: Image.memory(image!)),
              );
            },
          ),
        RepaintBoundary(
          key: _key,
          child: child,
        ),
      ],
    );
  }

  /// The child widget that will be thickened with multiple layers.
  late final Widget child = widget.child;

  /// The key used to convert the [child] widget to an image.
  late final GlobalKey _key;

  /// The generated image of the [child] widget.
  Uint8List? image;

  /// Converts the [child] widget to an image.
  ///
  /// Returns a [Future] that completes with the [Uint8List] of the image.
  Future<Uint8List?> toBitmap() async {
    try {
      // Wait until after the frame is built
      await Future.delayed(Duration.zero);

      final boundary = _key.currentContext?.findRenderObject();
      if (boundary is RenderRepaintBoundary) {
        final image = await boundary.toImage(pixelRatio: widget.pixelRatio);
        final byte = await image.toByteData(
          format: ui.ImageByteFormat.png,
        );

        return byte?.buffer.asUint8List();
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        try {
          final image = await toBitmap();
          setState(() => this.image = image);
        } catch (_) {
          // do nothing
        }
      });
    }
  }
}

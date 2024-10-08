import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thicken/thicken.dart';

void main() {
  testWidgets('Thicken Widget Test', (WidgetTester tester) async {
    debugPrint("✅ Test is started !");
    await tester.pumpWidget(
      const MaterialApp(
        home: Thicken(
          thickness: 2.5,
          child: Text(
            'Thickened Text',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );

    expect(
      find.text('Thickened Text'),
      findsWidgets,
      reason: 'Verify that the text is displayed',
    );
    debugPrint("✅ Thicken child widget found !");

    // // Get the Thicken widget
    final thickenWidget = tester.widget<Thicken>(find.byType(Thicken));
    expect(
      find.byWidget(thickenWidget),
      findsOne,
      reason: 'Verify that the widget exists',
    );
    debugPrint("✅ Thicken widget found !");

    // Calculate the total number of layers in the stack
    final stack = tester.widget<Stack>(find.byType(Stack));
    expect(
      find.byWidget(stack),
      findsOne,
      reason: 'Verify that the stack widget exists',
    );
    debugPrint("✅ ${stack.children.length} Stack children found !");

    // Calculate the expected number of layers
    final expectedLayers = 3 + (thickenWidget.thickness.floor() * 2);
    expect(
      stack.children.length,
      expectedLayers * expectedLayers,
      reason: 'Verify that the expected number of layers is rendered',
    );
    debugPrint("✅ $expectedLayers Layers found as expected !");
    debugPrint("✅ Test is finished !");
  });
}

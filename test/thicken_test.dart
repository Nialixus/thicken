import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thicken/thicken.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Thicken Widget Initial Test', (WidgetTester tester) async {
    debugPrint("\x1B[33m[1] Initial Test is started ... \x1B[32m✔️");
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
    await tester.pumpAndSettle();
    await tester.pump();

    // Verify that the text is displayed
    expect(
      find.text('Thickened Text'),
      findsWidgets,
      reason: 'Verify that the text is displayed',
    );
    debugPrint("\x1B[33m[2] Verify that the text is displayed ... \x1B[32m✔️");

    // Verify that the 'Thicken' widget exists
    final thickenWidget = tester.widget<Thicken>(find.byType(Thicken));
    expect(
      find.byWidget(thickenWidget),
      findsOne,
      reason: "Verify that the 'Thicken' widget exists",
    );
    debugPrint(
        "\x1B[33m[3] Verify that the 'Thicken' widget exists ... \x1B[32m✔️");

    // Verify that the 'Stack' widget exists
    final stack = tester.widget<Stack>(find.byType(Stack));
    expect(
      find.byWidget(stack),
      findsOne,
      reason: "Verify that the 'Stack' widget exists",
    );
    debugPrint(
      "\x1B[33m[4] Verify that the 'Stack' widget inside 'Thicken' exists ... \x1B[32m✔️",
    );

    // Calculate the expected number of layers
    // Verify that the child of stack widget is only one
    expect(
      stack.children.length,
      1,
      reason: 'Verify that the child of stack widget is only one',
    );
    debugPrint(
      "\x1B[33m[5] Verify that the child of stack widget is only ${stack.children.length} found ... \x1B[32m✔️",
    );
    debugPrint("\x1B[33m[5] Initial test is finished ... \x1B[32m✔️");
  });

  testWidgets('Thicken Widget Final Test', (tester) async {
    debugPrint("\x1B[33m[6] Final test is started ... \x1B[32m✔️");
    await tester.runAsync(() async {
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
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      await tester.pump();

      // Verify that the text is displayed
      expect(
        find.text('Thickened Text'),
        findsWidgets,
        reason: 'Verify that the text is displayed',
      );
      debugPrint(
          "\x1B[33m[7] Verify that the text is displayed ... \x1B[32m✔️");

      // Verify that the 'Thicken' widget exists
      final thickenWidget = tester.widget<Thicken>(find.byType(Thicken));
      expect(
        find.byWidget(thickenWidget),
        findsOne,
        reason: "Verify that the 'Thicken' widget exists",
      );
      debugPrint(
          "\x1B[33m[8] Verify that the 'Thicken' widget exists ... \x1B[32m✔️");

      // Verify that the 'Stack' widget exists
      final stack = tester.widget<Stack>(find.byType(Stack));
      expect(
        find.byWidget(stack),
        findsOne,
        reason: "Verify that the 'Stack' widget exists",
      );
      debugPrint(
        "\x1B[33m[9] Verify that the 'Stack' widget inside 'Thicken' exists ... \x1B[32m✔️",
      );
      final calculated = 3 + (thickenWidget.thickness.floor() * 2);
      final layers = calculated * calculated + 1;
      expect(
        stack.children.length,
        layers,
        reason: 'Verify that the child of stack widget is only one',
      );
      debugPrint(
        "\x1B[33m[10] Verify that the child of stack widget is equal to $layers layers. ... \x1B[32m✔️",
      );

      // Verify that the 'Image.memory' widget exists
      expect(
        tester.allWidgets.any((child) => child is Image),
        isTrue,
        reason: "Verify that the 'Image.memory' widget exists",
      );
      debugPrint(
        "\x1B[33m[11] Verify that the 'Image.memory' widget inside 'Thicken' exists ... \x1B[32m✔️",
      );
      debugPrint("\x1B[33m[12] Final test is finished ... \x1B[32m✔️");
    });
  });
}

import 'package:flutter/material.dart';
import 'package:thicken/thicken.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Thicken Example',
      home: Scaffold(
        body: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MAP();
}

class _MAP extends State<MyApp> {
  double thickness = 0.15;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Thicken(
          thickness: thickness,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.format_bold_rounded,
                color: Colors.black,
              ),
              Text(
                'Thicc',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        Center(
          child: Thicken(
            thickness: thickness,
            child: const Icon(
              Icons.accessibility_new_rounded,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: Slider(
            value: thickness,
            min: 0.0,
            max: 10.0,
            onChanged: (value) => setState(() => thickness = value),
          ),
        ),
        Visibility(
          visible: thickness > 1.0,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: const Text.rich(
            TextSpan(
              children: [
                WidgetSpan(child: Icon(Icons.warning, color: Colors.red)),
                TextSpan(
                  text: ' '
                      'It is not recommended to use '
                      'a thickness that is greater than 1.0',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

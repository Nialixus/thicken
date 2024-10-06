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
          child: const Text(
            'Thicc',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
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
            max: 2.0,
            onChanged: (value) => setState(() => thickness = value),
          ),
        ),
      ],
    );
  }
}

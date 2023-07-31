import 'package:flutter/material.dart';
import 'package:unreal_space/ar_screen.dart';

class ARApp extends StatelessWidget {
  const ARApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ARScreen(),
    );
  }
}

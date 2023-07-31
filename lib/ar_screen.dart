import 'package:flutter/material.dart';
import 'package:unreal_space/examples/custom_object.dart';

class ARScreen extends StatelessWidget {
  const ARScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArCore Demo'),
      ),
      body: const CustomObject(),
    );
  }
}

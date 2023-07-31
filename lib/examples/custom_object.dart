import 'dart:typed_data';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomObject extends StatefulWidget {
  const CustomObject({super.key});

  @override
  State<CustomObject> createState() => _CustomObjectState();
}

class _CustomObjectState extends State<CustomObject> {
  ArCoreController? controller;

  @override
  Widget build(BuildContext context) {
    return ArCoreView(
      enableTapRecognizer: true,
      onArCoreViewCreated: _onArCoreViewCreated,
    );
  }

  void _onArCoreViewCreated(ArCoreController ctrl) {
    controller = ctrl;
    controller?.onNodeTap = (name) => onTapHandler(name);
    controller?.onPlaneTap = _handleOnPlaneTap;
  }

  void onTapHandler(String name) {
    debugPrint("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    if (hits.isNotEmpty) {
      final hit = hits.first;
      _addSphere(hit);
    }
  }

  Future _addSphere(ArCoreHitTestResult hit) async {
    final moonMaterial = ArCoreMaterial(color: Colors.grey);

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );

    final moon = ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(0.2, 0, 0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    final ByteData textureBytes = await rootBundle.load('assets/earth.jpeg');

    final earthMaterial = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.2,
    );

    final earth = ArCoreNode(
      shape: earthShape,
      children: [moon],
      position: hit.pose.translation + vector.Vector3(0.0, 1.0, 0.0),
      rotation: hit.pose.rotation,
    );

    controller?.addArCoreNodeWithAnchor(earth);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

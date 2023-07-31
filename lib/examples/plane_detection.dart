import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlaneDetection extends StatefulWidget {
  const PlaneDetection({super.key});

  @override
  State<PlaneDetection> createState() => _PlaneDetectionState();
}

class _PlaneDetectionState extends State<PlaneDetection> {
  ArCoreController? controller;
  ArCoreNode? node;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plane detect handler'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableUpdateListener: true,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController ctrl) {
    controller = ctrl;
    controller?.onPlaneDetected = _handleOnPlaneDetected;
  }

  void _handleOnPlaneDetected(ArCorePlane plane) {
    if (node != null) {
      controller?.removeNode(nodeName: node!.name);
    }
    _addSphere(plane);
  }

  Future _addSphere(ArCorePlane plane) async {
    final ByteData textureBytes = await rootBundle.load('assets/earth.jpeg');

    final material = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.2,
    );
    node = ArCoreNode(
      shape: sphere,
      position: plane.centerPose?.translation,
      rotation: plane.centerPose?.rotation,
    );
    controller?.addArCoreNodeWithAnchor(node!);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

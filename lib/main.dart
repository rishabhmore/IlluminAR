import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show ArCoreController;
import 'package:unreal_space/ar_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ArCoreController.checkArCoreAvailability();
  await ArCoreController.checkIsArCoreInstalled();
  runApp(const ARApp());
}

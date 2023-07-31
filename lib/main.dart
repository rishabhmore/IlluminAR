import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show ArCoreController;
import 'package:unreal_space/ar_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('ARCORE IS AVAILABLE? ');
  debugPrint(await ArCoreController.checkArCoreAvailability());
  debugPrint('\nAR SERVICES INSTALLED? ');
  debugPrint(await ArCoreController.checkIsArCoreInstalled());
  runApp(const ARApp());
}
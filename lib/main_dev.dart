import 'package:flutter/material.dart';
import 'flavor_config.dart';
import 'main.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  FlavorConfig.initialize(
    flavor: Flavor.dev,
    apiBaseUrl: 'https://api-dev.reative.com',
    appTitle: 'Reative Dev',
    primaryColor: Colors.teal,
  );
  
  await app.mainCommon();
}

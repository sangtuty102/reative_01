import 'package:flutter/material.dart';
import 'flavor_config.dart';
import 'main.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  FlavorConfig.initialize(
    flavor: Flavor.prod,
    apiBaseUrl: 'https://api.reative.com',
    appTitle: 'Reative',
    primaryColor: Colors.indigo,
  );
  
  await app.mainCommon();
}

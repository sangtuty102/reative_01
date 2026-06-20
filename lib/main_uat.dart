import 'package:flutter/material.dart';
import 'flavor_config.dart';
import 'main.dart' as app;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  FlavorConfig.initialize(
    flavor: Flavor.uat,
    apiBaseUrl: 'https://api-uat.reative.com',
    appTitle: 'Reative UAT',
    primaryColor: Colors.orange,
  );
  
  app.mainCommon();
}

import 'package:flutter/material.dart';

enum Flavor { dev, uat, prod }

class FlavorConfig {
  final Flavor flavor;
  final String apiBaseUrl;
  final String appTitle;
  final Color primaryColor;

  static FlavorConfig? _instance;

  FlavorConfig._internal({
    required this.flavor,
    required this.apiBaseUrl,
    required this.appTitle,
    required this.primaryColor,
  });

  static void initialize({
    required Flavor flavor,
    required String apiBaseUrl,
    required String appTitle,
    required Color primaryColor,
  }) {
    _instance = FlavorConfig._internal(
      flavor: flavor,
      apiBaseUrl: apiBaseUrl,
      appTitle: appTitle,
      primaryColor: primaryColor,
    );
  }

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig has not been initialized. Call initialize() first.');
    }
    return _instance!;
  }

  static bool get isDev => instance.flavor == Flavor.dev;
  static bool get isUat => instance.flavor == Flavor.uat;
  static bool get isProd => instance.flavor == Flavor.prod;
}

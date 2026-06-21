import 'package:flutter/material.dart';
import 'package:reative_01/core/theme/app_colors.dart';
import 'colors/light_colors.dart';
import 'colors/dark_colors.dart';

/// Định nghĩa ThemeData cho giao diện Sáng và Tối
class AppTheme {
  // Prevent instantiation
  AppTheme._();

  static final AppColors _light = LightColors();
  static final AppColors _dark = DarkColors();

  /// Giao diện sáng (Light Theme)
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: _light.bgPrimary50,
      surface: _light.bgGrey0,
      onSurface: _light.textGrey90,
    ),
    scaffoldBackgroundColor: _light.bgGrey10,
    appBarTheme: AppBarTheme(
      backgroundColor: _light.bgPrimary50,
      foregroundColor: _light.textGrey0,
      centerTitle: true,
    ),
  );

  /// Giao diện tối (Dark Theme)
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: _dark.bgPrimary50,
      surface: _dark.bgGrey0,
      onSurface: _dark.textGrey90,
    ),
    scaffoldBackgroundColor: _dark.bgGrey10,
    appBarTheme: AppBarTheme(
      backgroundColor: _dark.bgGrey10,
      foregroundColor: _dark.textGrey90,
      centerTitle: true,
    ),
  );
}

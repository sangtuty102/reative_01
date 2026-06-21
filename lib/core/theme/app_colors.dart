import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors/light_colors.dart';
import 'colors/dark_colors.dart';

abstract class AppColors {
  static final AppColors _light = LightColors();
  static final AppColors _dark = DarkColors();

  /// Global getter để UI gọi màu dễ dàng (sẽ tự động bắt Theme hiện tại)
  static AppColors get current => Get.isDarkMode ? _dark : _light;

  // ===========================================================================
  // 1. TEXT COLORS
  // ===========================================================================
  Color get textGrey0;
  Color get textGrey10;
  Color get textGrey20;
  Color get textGrey30;
  Color get textGrey40;
  Color get textGrey50;
  Color get textGrey60;
  Color get textGrey70;
  Color get textGrey80;
  Color get textGrey90;

  Color get textPrimary0;
  Color get textPrimary10;
  Color get textPrimary20;
  Color get textPrimary30;
  Color get textPrimary40;
  Color get textPrimary50;
  Color get textPrimary60;
  Color get textPrimary70;
  Color get textPrimary80;
  Color get textPrimary90;

  Color get textSecondary0;
  Color get textSecondary10;
  Color get textSecondary20;
  Color get textSecondary30;
  Color get textSecondary40;
  Color get textSecondary50;
  Color get textSecondary60;
  Color get textSecondary70;
  Color get textSecondary80;
  Color get textSecondary90;

  Color get textSuccess0;
  Color get textSuccess10;
  Color get textSuccess20;
  Color get textSuccess30;
  Color get textSuccess40;
  Color get textSuccess50;
  Color get textSuccess60;
  Color get textSuccess70;
  Color get textSuccess80;
  Color get textSuccess90;

  Color get textError0;
  Color get textError10;
  Color get textError20;
  Color get textError30;
  Color get textError40;
  Color get textError50;
  Color get textError60;
  Color get textError70;
  Color get textError80;
  Color get textError90;

  // ===========================================================================
  // 2. BACKGROUND COLORS
  // ===========================================================================
  Color get bgGrey0;
  Color get bgGrey10;
  Color get bgGrey20;
  Color get bgGrey30;
  Color get bgGrey40;
  Color get bgGrey50;
  Color get bgGrey60;
  Color get bgGrey70;
  Color get bgGrey80;
  Color get bgGrey90;

  Color get bgPrimary0;
  Color get bgPrimary10;
  Color get bgPrimary20;
  Color get bgPrimary30;
  Color get bgPrimary40;
  Color get bgPrimary50;
  Color get bgPrimary60;
  Color get bgPrimary70;
  Color get bgPrimary80;
  Color get bgPrimary90;

  Color get bgSecondary0;
  Color get bgSecondary10;
  Color get bgSecondary20;
  Color get bgSecondary30;
  Color get bgSecondary40;
  Color get bgSecondary50;
  Color get bgSecondary60;
  Color get bgSecondary70;
  Color get bgSecondary80;
  Color get bgSecondary90;

  Color get bgSuccess0;
  Color get bgSuccess10;
  Color get bgSuccess20;
  Color get bgSuccess30;
  Color get bgSuccess40;
  Color get bgSuccess50;
  Color get bgSuccess60;
  Color get bgSuccess70;
  Color get bgSuccess80;
  Color get bgSuccess90;

  Color get bgError0;
  Color get bgError10;
  Color get bgError20;
  Color get bgError30;
  Color get bgError40;
  Color get bgError50;
  Color get bgError60;
  Color get bgError70;
  Color get bgError80;
  Color get bgError90;

  // ===========================================================================
  // 3. BUTTON COLORS
  // ===========================================================================
  Color get btnGrey0;
  Color get btnGrey10;
  Color get btnGrey20;
  Color get btnGrey30;
  Color get btnGrey40;
  Color get btnGrey50;
  Color get btnGrey60;
  Color get btnGrey70;
  Color get btnGrey80;
  Color get btnGrey90;

  Color get btnPrimary0;
  Color get btnPrimary10;
  Color get btnPrimary20;
  Color get btnPrimary30;
  Color get btnPrimary40;
  Color get btnPrimary50;
  Color get btnPrimary60;
  Color get btnPrimary70;
  Color get btnPrimary80;
  Color get btnPrimary90;

  Color get btnSecondary0;
  Color get btnSecondary10;
  Color get btnSecondary20;
  Color get btnSecondary30;
  Color get btnSecondary40;
  Color get btnSecondary50;
  Color get btnSecondary60;
  Color get btnSecondary70;
  Color get btnSecondary80;
  Color get btnSecondary90;

  Color get btnSuccess0;
  Color get btnSuccess10;
  Color get btnSuccess20;
  Color get btnSuccess30;
  Color get btnSuccess40;
  Color get btnSuccess50;
  Color get btnSuccess60;
  Color get btnSuccess70;
  Color get btnSuccess80;
  Color get btnSuccess90;

  Color get btnError0;
  Color get btnError10;
  Color get btnError20;
  Color get btnError30;
  Color get btnError40;
  Color get btnError50;
  Color get btnError60;
  Color get btnError70;
  Color get btnError80;
  Color get btnError90;

  // ===========================================================================
  // 4. BORDER COLORS
  // ===========================================================================
  Color get borderGrey0;
  Color get borderGrey10;
  Color get borderGrey20;
  Color get borderGrey30;
  Color get borderGrey40;
  Color get borderGrey50;
  Color get borderGrey60;
  Color get borderGrey70;
  Color get borderGrey80;
  Color get borderGrey90;

  Color get borderPrimary0;
  Color get borderPrimary10;
  Color get borderPrimary20;
  Color get borderPrimary30;
  Color get borderPrimary40;
  Color get borderPrimary50;
  Color get borderPrimary60;
  Color get borderPrimary70;
  Color get borderPrimary80;
  Color get borderPrimary90;

  Color get borderSecondary0;
  Color get borderSecondary10;
  Color get borderSecondary20;
  Color get borderSecondary30;
  Color get borderSecondary40;
  Color get borderSecondary50;
  Color get borderSecondary60;
  Color get borderSecondary70;
  Color get borderSecondary80;
  Color get borderSecondary90;

  Color get borderSuccess0;
  Color get borderSuccess10;
  Color get borderSuccess20;
  Color get borderSuccess30;
  Color get borderSuccess40;
  Color get borderSuccess50;
  Color get borderSuccess60;
  Color get borderSuccess70;
  Color get borderSuccess80;
  Color get borderSuccess90;

  Color get borderError0;
  Color get borderError10;
  Color get borderError20;
  Color get borderError30;
  Color get borderError40;
  Color get borderError50;
  Color get borderError60;
  Color get borderError70;
  Color get borderError80;
  Color get borderError90;
}

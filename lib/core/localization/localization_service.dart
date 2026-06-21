import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dịch vụ quản lý Đa ngôn ngữ (i18n)
class LocalizationService extends GetxService {
  final SharedPreferences _prefs;
  static const String _localeKey = 'languageCode';

  LocalizationService(this._prefs);

  /// Ngôn ngữ mặc định
  static const Locale fallbackLocale = Locale('vi', 'VN');

  /// Danh sách các ngôn ngữ được hỗ trợ
  static final locales = [
    const Locale('vi', 'VN'),
    const Locale('en', 'US'),
  ];

  /// Biến lưu trữ mã ngôn ngữ hiện tại (Reactive)
  late final RxString currentLanguageCode;

  /// Khởi tạo dịch vụ
  Future<LocalizationService> init() async {
    currentLanguageCode = (_prefs.getString(_localeKey) ?? 'vi').obs;
    return this;
  }

  /// Lấy ngôn ngữ hiện tại đang được lưu (để khởi tạo app)
  Locale get currentLocale {
    return currentLanguageCode.value == 'en' ? const Locale('en', 'US') : const Locale('vi', 'VN');
  }

  /// Đổi ngôn ngữ giữa tiếng Việt và tiếng Anh
  void toggleLanguage() {
    final newLang = currentLanguageCode.value == 'vi' ? 'en' : 'vi';
    currentLanguageCode.value = newLang;
    _prefs.setString(_localeKey, newLang);
    final locale = newLang == 'en' ? const Locale('en', 'US') : const Locale('vi', 'VN');
    Get.updateLocale(locale);
  }
}

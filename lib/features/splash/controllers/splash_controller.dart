import 'dart:async';
import 'package:get/get.dart';
import '../../../core/base/base_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/auth_service.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    _startSplashDelay();
  }

  void _startSplashDelay() {
    final authService = Get.find<AuthService>();
    Timer(const Duration(seconds: 2), () {
      if (authService.isLoggedIn.value) {
        Get.offAllNamed(Routes.home, arguments: authService.userName.value);
      } else {
        Get.offAllNamed(Routes.login);
      }
    });
  }
}

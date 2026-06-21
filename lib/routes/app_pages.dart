import 'package:get/get.dart';
import '../features/home/bindings/home_binding.dart';
import '../features/home/views/home_view.dart';
import '../features/login/bindings/login_binding.dart';
import '../features/login/views/login_view.dart';
import '../features/splash/bindings/splash_binding.dart';
import '../features/splash/views/splash_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}

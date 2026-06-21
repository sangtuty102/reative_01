import 'package:flutter/material.dart';
import '../../../core/base/base_view.dart';
import '../../../flavor_config.dart';
import '../controllers/splash_controller.dart';

class SplashView extends BaseView<SplashController> {
  const SplashView({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final config = FlavorConfig.instance;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.surface,
            colorScheme.surfaceContainer,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo / App Icon Placeholder with animations
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: config.primaryColor.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: config.primaryColor,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: config.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                Icons.flash_on,
                size: 64,
                color: config.primaryColor,
              ),
            ),
            const SizedBox(height: 32),
            // App Title
            Text(
              config.appTitle,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            Text(
              'Xây Dựng Trên Cấu Trúc GetX Base',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 64),
            // Loading Spinner
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(config.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

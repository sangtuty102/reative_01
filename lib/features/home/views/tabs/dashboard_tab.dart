import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reative_01/generated/locales.g.dart';
import '../../../../flavor_config.dart';
import '../../controllers/home_controller.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final config = FlavorConfig.instance;
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Premium Flavor Info Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      color: colorScheme.surfaceContainerHighest,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: config.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'FLAVOR: ${config.flavor.name.toUpperCase()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildInfoRow(context, 'App Name:', config.appTitle),
                            const Divider(height: 24),
                            _buildInfoRow(context, 'API Endpoint:', config.apiBaseUrl),
                            const Divider(height: 24),
                            Obx(() => TextButton.icon(
                                  onPressed: controller.isCheckingUpdate.value
                                      ? null
                                      : () => controller.checkUpdates(silent: false),
                                  icon: controller.isCheckingUpdate.value
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Icon(Icons.update),
                                  label: Text(LocaleKeys.homeCheckUpdate.tr),
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      LocaleKeys.homePushButtonMsg.tr,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Text(
                          '${controller.counter.value}',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        )),
                    const SizedBox(height: 40),
                    Obx(() => Text(
                          '${LocaleKeys.homeCurrentVersion.tr}${controller.appVersion.value}',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

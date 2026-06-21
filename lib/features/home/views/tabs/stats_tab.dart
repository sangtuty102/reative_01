import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reative_01/generated/locales.g.dart';
import '../../../../flavor_config.dart';
import '../../controllers/home_controller.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final colorScheme = Theme.of(context).colorScheme;
    final config = FlavorConfig.instance;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.homeSystemStats.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            LocaleKeys.homeSystemStatsDesc.tr,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          // Grid layout of Stats Cards
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.3,
            children: [
              Obx(() => _buildStatCard(
                    context,
                    title: LocaleKeys.homeClickCount.tr,
                    value: '${controller.counter.value}',
                    icon: Icons.ads_click,
                    color: config.primaryColor,
                  )),
              Obx(() => _buildStatCard(
                    context,
                    title: LocaleKeys.homeVersion.tr,
                    value: controller.appVersion.value,
                    icon: Icons.info_outline,
                    color: Colors.purple,
                  )),
              _buildStatCard(
                context,
                title: LocaleKeys.homeEnvironment.tr,
                value: config.flavor.name.toUpperCase(),
                icon: Icons.cloud_done_outlined,
                color: Colors.amber,
              ),
              _buildStatCard(
                context,
                title: LocaleKeys.homeSecurity.tr,
                value: LocaleKeys.homeSecurityStandardMet.tr,
                icon: Icons.security,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // System Status Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.homeServerStatus.tr,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildStatusRow(context, LocaleKeys.homeGatewayApi.tr,
                      LocaleKeys.homeActive.tr, Colors.green),
                  const Divider(),
                  _buildStatusRow(context, LocaleKeys.homeUpdateService.tr,
                      LocaleKeys.homeReady.tr, Colors.green),
                  const Divider(),
                  _buildStatusRow(context, LocaleKeys.homeDatabase.tr,
                      LocaleKeys.homeOnline.tr, Colors.green),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(
    BuildContext context,
    String label,
    String status,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              status,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

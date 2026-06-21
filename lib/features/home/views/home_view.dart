import 'package:reative_01/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/base/base_view.dart';
import '../../../flavor_config.dart';
import '../controllers/home_controller.dart';
import 'tabs/dashboard_tab.dart';
import 'tabs/stats_tab.dart';
import 'tabs/settings_tab.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final config = FlavorConfig.instance;
    return AppBar(
      backgroundColor: colorScheme.primaryContainer,
      title: Obx(() {
        String title = config.appTitle;
        if (controller.currentTabIndex.value == 1) {
          title = LocaleKeys.homeStats.tr;
        } else if (controller.currentTabIndex.value == 2) {
          title = LocaleKeys.homeSettings.tr;
        }
        return Text(
          title,
          style: TextStyle(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        );
      }),
      centerTitle: true,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: const [
        DashboardTab(),
        StatsTab(),
        SettingsTab(),
      ],
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Obx(() {
      // Only show FloatingActionButton on Dashboard Tab
      if (controller.currentTabIndex.value != 0) {
        return const SizedBox.shrink();
      }
      return FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'Increment',
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        child: const Icon(Icons.add),
      );
    });
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    final config = FlavorConfig.instance;
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.currentTabIndex.value,
          onTap: controller.changeTab,
          selectedItemColor: config.primaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.dashboard_rounded),
              label: LocaleKeys.homeHome.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart_rounded),
              label: LocaleKeys.homeStats.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_rounded),
              label: LocaleKeys.homeSettings.tr,
            ),
          ],
        ));
  }
}


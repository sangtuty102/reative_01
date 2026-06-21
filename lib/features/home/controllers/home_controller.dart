import 'package:reative_01/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/base/base_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/update_service.dart';

class HomeController extends BaseController {
  final RxInt counter = 0.obs;
  final RxString appVersion = '...'.obs;
  final RxString userName = 'Nguyễn Văn A'.obs;

  // Tab and PageView management
  final RxInt currentTabIndex = 0.obs;
  final PageController pageController = PageController();

  // Update check states
  final RxBool isCheckingUpdate = false.obs;
  final RxDouble updateProgress = 0.0.obs;
  final RxBool isDownloading = false.obs;
  final RxString downloadError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAppVersion();
    
    // Retrieve argument passed from Login page
    if (Get.arguments != null && Get.arguments is String) {
      userName.value = Get.arguments as String;
    }

    // Silent check for updates on startup after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUpdates(silent: true);
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    currentTabIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int index) {
    currentTabIndex.value = index;
  }

  Future<void> logout() async {
    await Get.find<AuthService>().clearSession();
    Get.offAllNamed(Routes.login);
  }

  void incrementCounter() {
    counter.value++;
  }

  Future<void> loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = 'v${packageInfo.version}+${packageInfo.buildNumber}';
    } catch (e) {
      appVersion.value = 'v1.0.0';
    }
  }

  Future<void> checkUpdates({required bool silent}) async {
    if (isCheckingUpdate.value) return;
    isCheckingUpdate.value = true;

    try {
      final updateInfo = await UpdateService.checkForUpdate();
      if (updateInfo != null) {
        _showUpdateDialog(updateInfo);
      } else {
        if (!silent) {
          Get.snackbar(
            LocaleKeys.commonNotification.tr,
            LocaleKeys.homeAppUpToDate.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.teal.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      if (!silent) {
        Get.snackbar(
          LocaleKeys.commonError.tr,
          '${LocaleKeys.homeUpdateCheckError.tr}$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
      }
    } finally {
      isCheckingUpdate.value = false;
    }
  }

  void _showUpdateDialog(UpdateInfo updateInfo) {
    Get.dialog(
      Obx(() => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text('${LocaleKeys.homeNewVersionAvailable.tr}${updateInfo.serverVersion})'),
            content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (updateInfo.changelog.isNotEmpty) ...[
                    Text(
                      LocaleKeys.homeNewFeatures.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(updateInfo.changelog),
                    const SizedBox(height: 16),
                  ],
                  if (isDownloading.value) ...[
                    Text(LocaleKeys.homeDownloadingUpdate.tr),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: updateProgress.value),
                    const SizedBox(height: 4),
                    Text(
                      '${(updateProgress.value * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ] else if (downloadError.value.isNotEmpty) ...[
                    Text(
                      downloadError.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ] else ...[
                    Text(LocaleKeys.homePromptDownloadUpdate.tr),
                  ],
                ],
              ),
            ),
            actions: [
              if (!isDownloading.value) ...[
                TextButton(
                  onPressed: () {
                    downloadError.value = '';
                    Get.back();
                  },
                  child: Text(LocaleKeys.commonSkip.tr),
                ),
                ElevatedButton(
                  onPressed: () {
                    isDownloading.value = true;
                    updateProgress.value = 0.0;
                    downloadError.value = '';
                    _startDownload(updateInfo.downloadUrl);
                  },
                  child: Text(LocaleKeys.commonUpdate.tr),
                ),
              ],
            ],
          )),
      barrierDismissible: false,
    );
  }

  void _startDownload(String url) {
    UpdateService.downloadAndInstall(
      url: url,
      onProgress: (progress) {
        updateProgress.value = progress;
      },
      onError: (error) {
        isDownloading.value = false;
        downloadError.value = error;
      },
    );
  }
}


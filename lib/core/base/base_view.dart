import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});

  /// The main UI of the page. Subclasses must implement this.
  Widget buildBody(BuildContext context);

  /// Standard AppBar. Subclasses can override this if needed.
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// Standard Floating Action Button. Subclasses can override if needed.
  Widget? buildFloatingActionButton(BuildContext context) => null;

  /// Standard Bottom Navigation Bar. Subclasses can override if needed.
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  /// Lấy ThemeData hiện tại
  ThemeData get theme => Theme.of(Get.context!);

  /// Lấy TextTheme hiện tại
  TextTheme get textTheme => theme.textTheme;

  /// Lấy ColorScheme hiện tại
  ColorScheme get colorScheme => theme.colorScheme;

  /// Scaffold background color. Override if needed.
  Color? get backgroundColor => theme.scaffoldBackgroundColor;

  /// Standard error UI. Subclasses can override if needed.
  Widget buildErrorView(BuildContext context) {
    return const Center(
      child: Text(
        'Đã xảy ra lỗi. Vui lòng thử lại!',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.isError) {
          return buildErrorView(context);
        }
        return buildBody(context);
      }),
      floatingActionButton: buildFloatingActionButton(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }
}

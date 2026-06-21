import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../flavor_config.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final RxBool? isLoading; // Optional reactive loading state
  final bool loading; // Fallback standard loading state
  final Color? color;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading,
    this.loading = false,
    this.color,
    this.width = double.infinity,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    final primaryColor = color ?? config.primaryColor;

    Widget buildButtonChild() {
      final showLoading = isLoading?.value ?? loading;
      if (showLoading) {
        return const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      }
      return Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    Widget button() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: primaryColor.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        onPressed: (isLoading?.value ?? loading) ? null : onPressed,
        child: buildButtonChild(),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: isLoading != null ? Obx(() => button()) : button(),
    );
  }
}

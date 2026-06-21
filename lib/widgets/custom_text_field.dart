import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../flavor_config.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final config = FlavorConfig.instance;
    Widget buildField({required bool obscureText, Widget? suffixIcon}) {
      return TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLength: maxLength,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: config.primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      );
    }

    if (!isPassword) {
      return buildField(obscureText: false);
    }

    final isPasswordVisible = false.obs;
    return Obx(() {
      return buildField(
        obscureText: !isPasswordVisible.value,
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () => isPasswordVisible.value = !isPasswordVisible.value,
        ),
      );
    });
  }
}

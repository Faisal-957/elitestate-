import 'package:elitestate/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,

      // User jo text likhega uska color
      style: const TextStyle(color: Colors.white, fontSize: 16),

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),

        prefixIcon: Icon(prefixIcon, color: Colors.white),

        filled: true,
        fillColor: Colors.black26,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white38),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: golden, width: 2),
        ),
      ),
    );
  }
}

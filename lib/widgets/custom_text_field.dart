import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final IconData? icon;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF3A1F14), width: 1.5),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: TextFormField(
          validator: validator,
          style: const TextStyle(color: Colors.white),
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              prefixIcon:
                  icon != null ? Icon(icon, color: Colors.grey[400]) : null,
              labelText: labelText,
              border: InputBorder.none, // Убираем рамку TextFormField
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputs {
  static Widget standard({
    required Color theme,
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter> inputFormatters = const [],
    required Icon prefixIcon,
    IconButton? suffixIcon,
    bool obscureText = false,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          obscureText: obscureText,
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            label: Text(label, style: const TextStyle(color: Colors.black, fontSize: 16)),
            labelStyle: const TextStyle(color: Colors.black),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: theme),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  static Widget search({
    Color background = const Color(0xFFE7E5E4),
    required IconButton? prefixIcon,
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.text,
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: prefixIcon,
            label: Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            labelStyle: const TextStyle(color: Colors.black),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            filled: true,
            fillColor: background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inputs {
  static Widget standard({
    required Color theme,
    required TextEditingController controller,
    required String label,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter> inputFormatters = const [],
    required Icon prefixIcon,
  }) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
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
}

import 'package:flutter/material.dart';

class CustomInputs {
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

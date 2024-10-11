import 'package:flutter/material.dart';
import 'package:irroba/app_config.dart';

Widget boxOptionMenu({
  required BuildContext context,
  required VoidCallback onPressedButton,
  required IconData icon,
  required String label,
}) {
  final theme = Theme.of(context).extension<CustomTheme>();
  return ElevatedButton(
    onPressed: onPressedButton,
    style: ElevatedButton.styleFrom(
      backgroundColor: theme?.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(115, 150, 150, 150),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 20),
        Text(label, style: const TextStyle(color: Colors.black, fontSize: 18)),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: theme?.primary,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            weight: 10,
            size: 16,
          ),
        ),
      ],
    ),
  );
}

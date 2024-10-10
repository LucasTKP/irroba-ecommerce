import 'package:flutter/material.dart';

class CustomCircularProgressIndicator {
  static Widget standard({required Color color, String text = 'Aguarde...'}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularProgressIndicator(
            color: color,
            backgroundColor: color.withOpacity(0.5),
            strokeWidth: 5,
          ),
          const SizedBox(height: 10),
          Text(text),
        ],
      ),
    );
  }
}

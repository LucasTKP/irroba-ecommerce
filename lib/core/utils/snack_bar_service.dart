import 'package:flutter/material.dart';

abstract class SnackBarService {
  void showMessage({required BuildContext context, required String message, required Color color});
}

class SnackBarServiceImpl implements SnackBarService {
  @override
  void showMessage({required BuildContext context, required String message, required Color color}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
      duration: const Duration(milliseconds: 3000),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

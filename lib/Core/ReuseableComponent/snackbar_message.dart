import 'package:flutter/material.dart';

const Duration duration = Duration(milliseconds: 1000);

class SnackBarMessage {
  static void showSuccessSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showErrorSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}

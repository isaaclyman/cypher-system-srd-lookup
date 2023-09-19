import 'package:flutter/material.dart';

SnackBar getErrorToast(String message) =>
    SnackBar(content: ErrorToast(message));

class ErrorToast extends StatelessWidget {
  final String message;

  const ErrorToast(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.error),
        Text(message),
      ],
    );
  }
}

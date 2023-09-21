import 'package:flutter/material.dart';

SnackBar cErrorToast(String message) => SnackBar(content: _ErrorToast(message));

class _ErrorToast extends StatelessWidget {
  final String message;

  const _ErrorToast(this.message);

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

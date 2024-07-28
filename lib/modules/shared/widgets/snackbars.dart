import 'package:flutter/material.dart';

successSnackBar(BuildContext context, String? message,
    {SnackBarAction? action}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? ""),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      action: action,
    ),
  );
}

errorSnackBar(BuildContext context, String? message, {SnackBarAction? action}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? ''),
      backgroundColor: Colors.red,
      action: action,
    ),
  );
}

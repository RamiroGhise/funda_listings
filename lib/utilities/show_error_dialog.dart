import 'package:flutter/material.dart';

/// Displays an [AlertDialog] on the screen.
///
/// Takes as parameter the [BuildContext] and a [String] to be displayed as the
/// content of the [AlertDialog].
/// Used to display errors to the user.
Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('An error occurred'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

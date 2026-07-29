import 'package:flutter/material.dart';

class NameInputDialog {
  static Future<String?> show(
    BuildContext context, {
    required String title,
    required String initialValue,
    String hintText = '',
  }) async {
    final controller = TextEditingController(
      text: initialValue,
    );

    final result = await showDialog<String>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: hintText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  controller.text.trim(),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    return result;
  }
}

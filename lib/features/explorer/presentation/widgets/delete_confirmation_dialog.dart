import 'package:flutter/material.dart';

class DeleteConfirmationDialog {
  static Future<bool> show(
    BuildContext context, {
    required int itemCount,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete'),
        content: Text(
          itemCount == 1
              ? 'Delete the selected item?'
              : 'Delete $itemCount selected items?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}

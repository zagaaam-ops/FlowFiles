import 'package:flutter/material.dart';

import '../../domain/entities/file_entity.dart';

class PropertiesDialog {
  PropertiesDialog._();

  static Future<void> show(
    BuildContext context,
    FileEntity file,
  ) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                file.isDirectory ? Icons.folder : Icons.insert_drive_file,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  file.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row('Name', file.name),
                _row('Path', file.path),
                _row(
                  'Type',
                  file.isDirectory
                      ? 'Folder'
                      : (file.extension.isEmpty
                          ? 'File'
                          : file.extension.toUpperCase()),
                ),
                _row('Size', '${file.size} bytes'),
                _row(
                  'Modified',
                  file.lastModified.toString(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  static Widget _row(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(value),
          ),
        ],
      ),
    );
  }
}

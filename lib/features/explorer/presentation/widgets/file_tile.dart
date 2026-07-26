import 'package:flutter/material.dart';

import '../../domain/entities/file_entity.dart';

/// Displays a single file in the Explorer.
class FileTile extends StatelessWidget {
  const FileTile({
    super.key,
    required this.file,
    this.onTap,
  });

  final FileEntity file;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.insert_drive_file_outlined),
      title: Text(file.name),
      subtitle: Text(
        '${file.size} bytes',
      ),
      trailing: Text(file.extension.toUpperCase()),
      onTap: onTap,
    );
  }
}

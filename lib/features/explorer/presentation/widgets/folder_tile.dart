import 'package:flutter/material.dart';

import '../../domain/entities/file_entity.dart';

/// Displays a single folder in the Explorer.
///
/// This widget is intentionally separate from [FileTile]
/// because folders will support additional functionality
/// such as:
/// - Item count
/// - Favorite indicator
/// - Destination highlighting
/// - Organizer Mode
class FolderTile extends StatelessWidget {
  const FolderTile({
    super.key,
    required this.folder,
    this.onTap,
  });

  final FileEntity folder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.folder_outlined,
        color: Colors.amber,
      ),
      title: Text(folder.name),
      subtitle: const Text('Folder'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

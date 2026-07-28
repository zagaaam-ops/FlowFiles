import 'package:flutter/material.dart';

import '../../domain/entities/file_entity.dart';

class FolderTile extends StatelessWidget {
  const FolderTile({
    super.key,
    required this.folder,
    required this.selected,
    this.onTap,
    this.onSecondaryTapDown,
  });

  final FileEntity folder;
  final bool selected;

  final VoidCallback? onTap;
  final GestureTapDownCallback? onSecondaryTapDown;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onSecondaryTapDown: onSecondaryTapDown,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 3,
        ),
        color: selected ? colorScheme.primaryContainer : null,
        child: ListTile(
          leading: const Icon(
            Icons.folder_outlined,
            color: Colors.amber,
          ),
          title: Text(folder.name),
          subtitle: const Text('Folder'),
          trailing: selected
              ? Icon(
                  Icons.check_circle,
                  color: colorScheme.primary,
                )
              : const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}

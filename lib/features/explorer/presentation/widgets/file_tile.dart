import 'package:flutter/material.dart';

import '../../../../core/utils/file_icon_utils.dart';
import '../../domain/entities/file_entity.dart';

class FileTile extends StatelessWidget {
  const FileTile({
    super.key,
    required this.file,
    required this.selected,
    this.onTap,
  });

  final FileEntity file;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      color: selected ? colorScheme.primaryContainer : null,
      child: ListTile(
        leading: Icon(
          FileIconUtils.getIcon(
            isDirectory: false,
            extension: file.extension,
          ),
        ),
        title: Text(file.name),
        subtitle: Text('${file.size} bytes'),
        trailing: selected
            ? Icon(
                Icons.check_circle,
                color: colorScheme.primary,
              )
            : const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

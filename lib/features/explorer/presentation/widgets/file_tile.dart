import 'package:flutter/material.dart';

import '../../../../core/utils/file_icon_utils.dart';
import '../../domain/entities/file_entity.dart';

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
      leading: Icon(
        FileIconUtils.getIcon(
          isDirectory: false,
          extension: file.extension,
        ),
      ),
      title: Text(file.name),
      subtitle: Text(
        '${file.size} bytes',
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

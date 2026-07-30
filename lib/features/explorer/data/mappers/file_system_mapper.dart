import 'dart:io';

import '../../domain/entities/explorer_file.dart';
import '../../domain/entities/explorer_folder.dart';

class FileSystemMapper {
  const FileSystemMapper._();

  static ExplorerFolder toFolder(Directory directory) {
    final name = directory.path.split(Platform.pathSeparator).last;

    return ExplorerFolder(
      name: name,
      path: directory.path,
    );
  }

  static Future<ExplorerFile> toFile(File file) async {
    final stat = await file.stat();

    final name = file.path.split(Platform.pathSeparator).last;

    final extension =
        name.contains('.') ? name.split('.').last.toLowerCase() : '';

    return ExplorerFile(
      name: name,
      path: file.path,
      extension: extension,
      size: stat.size,
      modified: stat.modified,
      isHidden: name.startsWith('.'),
    );
  }
}

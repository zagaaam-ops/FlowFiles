import 'dart:io';

import 'package:path/path.dart' as p;

import '../../domain/entities/directory_entity.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/repositories/explorer_repository.dart';
import '../datasources/local_file_system_data_source.dart';

class ExplorerRepositoryImpl implements ExplorerRepository {
  ExplorerRepositoryImpl(this._dataSource);

  final LocalFileSystemDataSource _dataSource;

  @override
  Future<bool> directoryExists(String path) {
    return _dataSource.directoryExists(path);
  }

  @override
  Future<DirectoryEntity> loadDirectory(String path) async {
    final entities = await _dataSource.listDirectory(path);

    final items = <FileEntity>[];

    for (final entity in entities) {
      final stat = await entity.stat();

      final isDirectory = entity is Directory;

      items.add(
        FileEntity(
          path: entity.path,
          name: p.basename(entity.path),
          isDirectory: isDirectory,
          size: isDirectory ? 0 : stat.size,
          lastModified: stat.modified,
          extension: isDirectory ? '' : p.extension(entity.path),
        ),
      );
    }

    return DirectoryEntity(
      path: path,
      name: p.basename(path),
      parentPath: Directory(path).parent.path,
      items: items,
    );
  }

  @override
  Future<DirectoryEntity> refreshDirectory(String path) {
    return loadDirectory(path);
  }

  @override
  Future<DirectoryEntity> openParentDirectory(String path) async {
    final parent = Directory(path).parent.path;
    return loadDirectory(parent);
  }

  @override
  Future<void> moveFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  }) async {
    for (final sourcePath in sourcePaths) {
      final source = File(sourcePath);

      if (!await source.exists()) {
        continue;
      }

      final destination = p.join(
        destinationPath,
        p.basename(sourcePath),
      );

      await source.rename(destination);
    }
  }
}

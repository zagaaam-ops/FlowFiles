import 'package:path/path.dart' as p;
import 'dart:io';

import '../../domain/entities/directory_entity.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/repositories/explorer_repository.dart';
import '../datasources/local_file_system_data_source.dart';

/// Concrete implementation of [ExplorerRepository].
///
/// Converts raw file system objects into immutable domain entities.
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
          name: entity.uri.pathSegments.isNotEmpty
              ? entity.uri.pathSegments.last
              : entity.path,
          isDirectory: isDirectory,
          size: isDirectory ? 0 : stat.size,
          lastModified: stat.modified,
          extension: isDirectory
              ? ''
              : entity.path.contains('.')
                  ? entity.path.split('.').last
                  : '',
        ),
      );
    }

    return DirectoryEntity(
      path: path,
      name: Directory(path).uri.pathSegments.isNotEmpty
          ? Directory(path).uri.pathSegments.last
          : path,
      parentPath: Directory(path).parent.path,
      items: items,
    );
  }

  @override
  Future<DirectoryEntity> openParentDirectory(String path) async {
    final parent = Directory(path).parent.path;
    return loadDirectory(parent);
  }

  @override
  Future<DirectoryEntity> refreshDirectory(String path) {
    return loadDirectory(path);
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

      final destination =
          p.join(destinationPath, p.basename(sourcePath));

      await source.rename(destination);
    }
  }

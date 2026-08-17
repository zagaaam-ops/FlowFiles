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
  Future<void> deleteFiles({
    required List<String> paths,
  }) async {
    for (final path in paths) {
      final entity = FileSystemEntity.typeSync(path);

      if (entity == FileSystemEntityType.file) {
        final file = File(path);

        if (await file.exists()) {
          await file.delete();
        }
      } else if (entity == FileSystemEntityType.directory) {
        final directory = Directory(path);

        if (await directory.exists()) {
          await directory.delete(recursive: true);
        }
      }
    }
  }

  @override
  Future<void> copyFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  }) async {
    for (final sourcePath in sourcePaths) {
      final type = await FileSystemEntity.type(
        sourcePath,
        followLinks: false,
      );

      final destination = p.join(
        destinationPath,
        p.basename(sourcePath),
      );

      if (type == FileSystemEntityType.file) {
        final source = File(sourcePath);

        if (await source.exists()) {
          await source.copy(destination);
        }
      } else if (type == FileSystemEntityType.directory) {
        final source = Directory(sourcePath);

        if (await source.exists()) {
          await _copyDirectory(
            source,
            Directory(destination),
          );
        }
      }
    }
  }

  Future<void> _copyDirectory(
    Directory source,
    Directory destination,
  ) async {
    await destination.create(recursive: true);

    await for (final entity in source.list(
      followLinks: false,
    )) {
      final targetPath = p.join(
        destination.path,
        p.basename(entity.path),
      );

      if (entity is File) {
        await entity.copy(targetPath);
      } else if (entity is Directory) {
        await _copyDirectory(
          entity,
          Directory(targetPath),
        );
      }
    }
  }

  @override
  Future<void> renameFile({
    required String sourcePath,
    required String newName,
  }) async {
    final type = await FileSystemEntity.type(
      sourcePath,
      followLinks: false,
    );

    if (type == FileSystemEntityType.file) {
      final source = File(sourcePath);

      if (await source.exists()) {
        final destination = p.join(
          p.dirname(sourcePath),
          newName,
        );

        await source.rename(destination);
      }
    } else if (type == FileSystemEntityType.directory) {
      final source = Directory(sourcePath);

      if (await source.exists()) {
        final destination = p.join(
          p.dirname(sourcePath),
          newName,
        );

        await source.rename(destination);
      }
    }
  }

  @override
  Future<void> moveFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  }) async {
    for (final sourcePath in sourcePaths) {
      final type = await FileSystemEntity.type(
        sourcePath,
        followLinks: false,
      );

      final destination = p.join(
        destinationPath,
        p.basename(sourcePath),
      );

      if (type == FileSystemEntityType.file) {
        final source = File(sourcePath);

        if (await source.exists()) {
          await source.rename(destination);
        }
      } else if (type == FileSystemEntityType.directory) {
        final source = Directory(sourcePath);

        if (await source.exists()) {
          await source.rename(destination);
        }
      }
    }
  }
}

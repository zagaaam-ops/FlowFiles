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
  Future<void> copyFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  }) async {
    for (final sourcePath in sourcePaths) {
      final type = FileSystemEntity.typeSync(sourcePath);

      final destination = p.join(
        destinationPath,
        p.basename(sourcePath),
      );

      if (type == FileSystemEntityType.file) {
        await File(sourcePath).copy(destination);
      } else if (type == FileSystemEntityType.directory) {
        await _copyDirectory(
          Directory(sourcePath),
          Directory(destination),
        );
      }
    }
  }

  @override
  Future<void> createFile({
    required String parentPath,
    required String fileName,
  }) async {
    final file = File(
      p.join(
        parentPath,
        fileName,
      ),
    );

    if (!await file.exists()) {
      await file.create();
    }
  }

  @override
  Future<void> createFolder({
    required String parentPath,
    required String folderName,
  }) async {
    final directory = Directory(
      p.join(
        parentPath,
        folderName,
      ),
    );

    await directory.create();
  }

  @override
  Future<void> rename(
    String sourcePath,
    String newName,
  ) async {
    final entity = FileSystemEntity.typeSync(sourcePath);

    final destination = p.join(
      p.dirname(sourcePath),
      newName,
    );

    switch (entity) {
      case FileSystemEntityType.file:
        await File(sourcePath).rename(destination);
        break;

      case FileSystemEntityType.directory:
        await Directory(sourcePath).rename(destination);
        break;

      default:
        throw Exception('Unsupported file system entity.');
    }
  }

  @override
  Future<void> moveFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  }) async {
    for (final sourcePath in sourcePaths) {
      final type = FileSystemEntity.typeSync(sourcePath);

      final destination = p.join(
        destinationPath,
        p.basename(sourcePath),
      );

      if (type == FileSystemEntityType.file) {
        await File(sourcePath).rename(destination);
      } else if (type == FileSystemEntityType.directory) {
        await Directory(sourcePath).rename(destination);
      }
    }
  }

  Future<void> _copyDirectory(
    Directory source,
    Directory destination,
  ) async {
    if (!await destination.exists()) {
      await destination.create(recursive: true);
    }

    await for (final entity in source.list(recursive: false)) {
      final newPath = p.join(
        destination.path,
        p.basename(entity.path),
      );

      if (entity is File) {
        await entity.copy(newPath);
      } else if (entity is Directory) {
        await _copyDirectory(
          entity,
          Directory(newPath),
        );
      }
    }
  }

  @override
  Future<void> deleteFiles({
    required List<String> sourcePaths,
  }) async {
    for (final path in sourcePaths) {
      final type = FileSystemEntity.typeSync(path);

      switch (type) {
        case FileSystemEntityType.file:
          await File(path).delete();
          break;

        case FileSystemEntityType.directory:
          await Directory(path).delete(recursive: true);
          break;

        default:
          break;
      }
    }
  }
}

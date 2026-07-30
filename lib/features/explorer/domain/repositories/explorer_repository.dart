import '../entities/directory_entity.dart';

abstract class ExplorerRepository {
  Future<DirectoryEntity> loadDirectory(String path);

  Future<DirectoryEntity> refreshDirectory(String path);

  Future<DirectoryEntity> openParentDirectory(String path);

  Future<bool> directoryExists(String path);

  /// Copies files and folders into another directory.
  Future<void> copyFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  });

  /// Moves files and folders into another directory.
  Future<void> moveFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  });

  /// Renames a file or folder.
  Future<void> rename(
    String sourcePath,
    String newName,
  );

  /// Creates a new folder inside the given parent directory.
  Future<void> createFolder({
    required String parentPath,
    required String folderName,
  });

  /// Creates a new empty file inside the given parent directory.
  Future<void> createFile({
    required String parentPath,
    required String fileName,
  });

  /// Deletes files and folders.
  Future<void> deleteFiles({
    required List<String> sourcePaths,
  });
}

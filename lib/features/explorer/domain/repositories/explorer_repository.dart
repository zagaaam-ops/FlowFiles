import '../entities/directory_entity.dart';

abstract class ExplorerRepository {
  Future<DirectoryEntity> loadDirectory(String path);

  Future<DirectoryEntity> refreshDirectory(String path);

  Future<DirectoryEntity> openParentDirectory(String path);

  Future<bool> directoryExists(String path);

  Future<void> deleteFiles({
    required List<String> paths,
  });

  Future<void> copyFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  });

  Future<void> moveFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  });

  Future<void> renameFile({
    required String sourcePath,
    required String newName,
  });
}

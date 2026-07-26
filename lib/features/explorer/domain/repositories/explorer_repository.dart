import '../entities/directory_entity.dart';

/// Contract for accessing the file system.
///
/// The domain layer depends on this abstraction rather than a
/// platform-specific implementation.
abstract class ExplorerRepository {
  /// Loads the contents of a directory.
  Future<DirectoryEntity> loadDirectory(String path);

  /// Reloads the current directory.
  Future<DirectoryEntity> refreshDirectory(String path);

  /// Opens the parent directory.
  Future<DirectoryEntity> openParentDirectory(String path);

  /// Returns true if the directory exists.
  Future<bool> directoryExists(String path);

  /// Moves files/directories to another folder.
  Future<void> moveFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  });
}

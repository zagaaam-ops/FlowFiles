import '../entities/directory_entity.dart';

/// Contract for accessing the file system.
///
/// The domain layer depends on this abstraction rather than a
/// platform-specific implementation.
///
/// Implementations may use:
/// - dart:io (Windows, Linux, macOS)
/// - Android storage APIs
/// - iOS file APIs
/// - Other platform-specific mechanisms
abstract class ExplorerRepository {
  /// Loads the contents of a directory.
  ///
  /// Throws an exception if the directory cannot be accessed.
  Future<DirectoryEntity> loadDirectory(String path);

  /// Reloads the currently opened directory.
  Future<DirectoryEntity> refreshDirectory(String path);

  /// Returns the parent directory.
  ///
  /// If the supplied path is already a root directory,
  /// implementations should return that same directory or handle
  /// the situation gracefully.
  Future<DirectoryEntity> openParentDirectory(String path);

  /// Returns true if the directory exists.
  Future<bool> directoryExists(String path);
}/// Moves files/directories from [sourcePaths] into [destinationPath].
  Future<void> moveFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  });

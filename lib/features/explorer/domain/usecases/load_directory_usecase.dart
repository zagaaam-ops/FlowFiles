import '../entities/directory_entity.dart';
import '../repositories/explorer_repository.dart';

/// Loads a directory from the repository.
///
/// This use case represents the primary business action of the
/// Explorer Engine.
///
/// Additional business rules such as:
/// - permission checking
/// - path validation
/// - logging
/// - analytics
/// can be added here without affecting the UI.
class LoadDirectoryUseCase {
  const LoadDirectoryUseCase(this._repository);

  final ExplorerRepository _repository;

  /// Loads the directory located at [path].
  Future<DirectoryEntity> call(String path) {
    return _repository.loadDirectory(path);
  }
}

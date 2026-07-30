import '../entities/directory_entity.dart';
import '../repositories/explorer_repository.dart';

/// Reloads the contents of the current directory.
class RefreshDirectoryUseCase {
  const RefreshDirectoryUseCase(this._repository);

  final ExplorerRepository _repository;

  Future<DirectoryEntity> call(String path) {
    return _repository.refreshDirectory(path);
  }
}

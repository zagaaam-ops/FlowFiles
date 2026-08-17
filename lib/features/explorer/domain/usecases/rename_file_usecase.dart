import '../repositories/explorer_repository.dart';

class RenameFileUseCase {
  RenameFileUseCase(this._repository);

  final ExplorerRepository _repository;

  Future<void> call({
    required String sourcePath,
    required String newName,
  }) {
    return _repository.renameFile(
      sourcePath: sourcePath,
      newName: newName,
    );
  }
}

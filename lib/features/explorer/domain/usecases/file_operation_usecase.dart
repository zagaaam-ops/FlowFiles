import '../repositories/explorer_repository.dart';

class FileOperationUseCase {
  const FileOperationUseCase(this._repository);

  final ExplorerRepository _repository;

  Future<void> copyFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  }) {
    return _repository.copyFiles(
      sourcePaths: sourcePaths,
      destinationPath: destinationPath,
    );
  }

  Future<void> moveFiles({
    required List<String> sourcePaths,
    required String destinationPath,
  }) {
    return _repository.moveFiles(
      sourcePaths: sourcePaths,
      destinationPath: destinationPath,
    );
  }
}

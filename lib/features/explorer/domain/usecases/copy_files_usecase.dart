import '../repositories/explorer_repository.dart';

class CopyFilesUseCase {
  const CopyFilesUseCase(
    this.repository,
  );

  final ExplorerRepository repository;

  Future<void> call({
    required List<String> sourcePaths,
    required String destinationPath,
  }) {
    return repository.copyFiles(
      sourcePaths: sourcePaths,
      destinationPath: destinationPath,
    );
  }
}

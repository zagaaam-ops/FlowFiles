import '../repositories/explorer_repository.dart';

class DeleteFilesUseCase {
  const DeleteFilesUseCase(
    this.repository,
  );

  final ExplorerRepository repository;

  Future<void> call({
    required List<String> sourcePaths,
  }) {
    return repository.deleteFiles(
      sourcePaths: sourcePaths,
    );
  }
}

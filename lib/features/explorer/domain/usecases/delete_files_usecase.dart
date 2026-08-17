import '../repositories/explorer_repository.dart';

class DeleteFilesUseCase {
  const DeleteFilesUseCase(
    this.repository,
  );

  final ExplorerRepository repository;

  Future<void> call({
    required List<String> paths,
  }) {
    return repository.deleteFiles(
      paths: paths,
    );
  }
}

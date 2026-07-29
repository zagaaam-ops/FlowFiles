import '../repositories/explorer_repository.dart';

class RenameUseCase {
  const RenameUseCase(
    this.repository,
  );

  final ExplorerRepository repository;

  Future<void> call({
    required String sourcePath,
    required String newName,
  }) {
    return repository.rename(
      sourcePath,
      newName,
    );
  }
}

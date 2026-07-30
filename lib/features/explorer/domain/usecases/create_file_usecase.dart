import '../repositories/explorer_repository.dart';

class CreateFileUseCase {
  const CreateFileUseCase(
    this.repository,
  );

  final ExplorerRepository repository;

  Future<void> call({
    required String parentPath,
    required String fileName,
  }) {
    return repository.createFile(
      parentPath: parentPath,
      fileName: fileName,
    );
  }
}

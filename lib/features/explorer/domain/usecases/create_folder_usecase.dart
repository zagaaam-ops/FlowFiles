import '../repositories/explorer_repository.dart';

class CreateFolderUseCase {
  const CreateFolderUseCase(
    this.repository,
  );

  final ExplorerRepository repository;

  Future<void> call({
    required String parentPath,
    required String folderName,
  }) {
    return repository.createFolder(
      parentPath: parentPath,
      folderName: folderName,
    );
  }
}

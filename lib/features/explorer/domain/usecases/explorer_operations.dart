import 'copy_files_usecase.dart';
import 'move_files_usecase.dart';

class ExplorerOperations {
  const ExplorerOperations({
    required this.copyFiles,
    required this.moveFiles,
  });

  final CopyFilesUseCase copyFiles;
  final MoveFilesUseCase moveFiles;
}

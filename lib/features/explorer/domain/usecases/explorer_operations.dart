import 'copy_files_usecase.dart';
import 'move_files_usecase.dart';
import 'rename_usecase.dart';
import 'delete_files_usecase.dart';

class ExplorerOperations {
  const ExplorerOperations({
    required this.copyFiles,
    required this.moveFiles,
    required this.deleteFiles,
    required this.rename,
  });

  final CopyFilesUseCase copyFiles;
  final MoveFilesUseCase moveFiles;
  final DeleteFilesUseCase deleteFiles;
  final RenameUseCase rename;
}

import '../../features/explorer/data/datasources/local_file_system_data_source.dart';
import '../../features/explorer/data/repositories/explorer_repository_impl.dart';
import '../../features/explorer/domain/usecases/load_directory_usecase.dart';
import '../../features/explorer/domain/usecases/copy_files_usecase.dart';
import '../../features/explorer/domain/usecases/delete_files_usecase.dart';
import '../../features/explorer/domain/usecases/move_files_usecase.dart';
import '../../features/explorer/domain/usecases/rename_usecase.dart';
import '../../features/explorer/domain/usecases/create_folder_usecase.dart';
import '../../features/explorer/domain/usecases/create_file_usecase.dart';
import '../../features/explorer/domain/usecases/explorer_operations.dart';
import '../../features/explorer/presentation/controllers/clipboard_controller.dart';
import '../../features/explorer/presentation/controllers/explorer_controller.dart';
import '../../features/explorer/presentation/controllers/selection_controller.dart';

/// Simple dependency container for FlowFiles.
///
/// Later this can be replaced by GetIt or Riverpod.
class ServiceLocator {
  ServiceLocator._();

  static final LocalFileSystemDataSource _dataSource =
      LocalFileSystemDataSource();

  static final ExplorerRepositoryImpl _repository =
      ExplorerRepositoryImpl(_dataSource);

  static final LoadDirectoryUseCase _loadDirectoryUseCase =
      LoadDirectoryUseCase(_repository);

  static final CopyFilesUseCase _copyFilesUseCase =
      CopyFilesUseCase(_repository);

  static final MoveFilesUseCase _moveFilesUseCase =
      MoveFilesUseCase(_repository);

  static final DeleteFilesUseCase _deleteFilesUseCase =
      DeleteFilesUseCase(_repository);

  static final RenameUseCase _renameUseCase = RenameUseCase(_repository);
  static final CreateFolderUseCase _createFolderUseCase =
      CreateFolderUseCase(_repository);

  static final CreateFileUseCase _createFileUseCase =
      CreateFileUseCase(_repository);

  static final ExplorerOperations explorerOperations = ExplorerOperations(
    copyFiles: _copyFilesUseCase,
    moveFiles: _moveFilesUseCase,
    deleteFiles: _deleteFilesUseCase,
    rename: _renameUseCase,
    createFolder: _createFolderUseCase,
    createFile: _createFileUseCase,
  );

  static final ExplorerController explorerController = ExplorerController(
    _loadDirectoryUseCase,
    explorerOperations,
  );

  static final SelectionController selectionController = SelectionController();

  static final ClipboardController clipboardController = ClipboardController();
}

import '../../features/explorer/data/datasources/local_file_system_data_source.dart';
import '../../features/explorer/data/repositories/explorer_repository_impl.dart';
import '../../features/explorer/domain/usecases/load_directory_usecase.dart';
import '../../features/explorer/presentation/controllers/explorer_controller.dart';

/// Simple dependency container for FlowFiles.
///
/// Later this can be replaced by GetIt or Riverpod,
/// but for now it keeps object creation centralized.
class ServiceLocator {
  ServiceLocator._();

  static final LocalFileSystemDataSource _dataSource =
      LocalFileSystemDataSource();

  static final ExplorerRepositoryImpl _repository =
      ExplorerRepositoryImpl(_dataSource);

  static final LoadDirectoryUseCase _loadDirectoryUseCase =
      LoadDirectoryUseCase(_repository);

  static final ExplorerController explorerController =
      ExplorerController(_loadDirectoryUseCase);
}

import 'package:flutter/foundation.dart';

import '../../../../core/enums/sort_option.dart';
import '../../../../core/utils/file_sort_utils.dart';
import '../../domain/entities/directory_entity.dart';
import '../../domain/usecases/load_directory_usecase.dart';
import '../state/explorer_state.dart';

/// Controls the Explorer feature.
///
/// Responsible for:
/// - Loading directories
/// - Managing loading state
/// - Managing errors
/// - Applying sorting
class ExplorerController extends ChangeNotifier {
  ExplorerController(this._loadDirectoryUseCase);

  final LoadDirectoryUseCase _loadDirectoryUseCase;

  ExplorerState _state = const ExplorerState();

  ExplorerState get state => _state;

  Future<void> openDirectory(String path) async {
    _state = _state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    notifyListeners();

    try {
      final DirectoryEntity directory =
          await _loadDirectoryUseCase(path);

      final sortedItems = FileSortUtils.sort(
        directory.items,
        _state.sortOption,
      );

      final sortedDirectory = DirectoryEntity(
        path: directory.path,
        name: directory.name,
        parentPath: directory.parentPath,
        items: sortedItems,
      );

      _state = _state.copyWith(
        directory: sortedDirectory,
        isLoading: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }

    notifyListeners();
  }

  void setSortOption(SortOption sortOption) {
    _state = _state.copyWith(
      sortOption: sortOption,
    );

    final directory = _state.directory;

    if (directory != null) {
      final sortedItems = FileSortUtils.sort(
        directory.items,
        sortOption,
      );

      _state = _state.copyWith(
        directory: DirectoryEntity(
          path: directory.path,
          name: directory.name,
          parentPath: directory.parentPath,
          items: sortedItems,
        ),
      );
    }

    notifyListeners();
  }
}

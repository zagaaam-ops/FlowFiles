import 'package:flutter/foundation.dart';

import '../../../../core/enums/sort_option.dart';
import '../../../../core/utils/file_search_utils.dart';
import '../../../../core/utils/file_sort_utils.dart';
import '../../domain/entities/directory_entity.dart';
import '../../domain/usecases/load_directory_usecase.dart';
import '../../domain/usecases/explorer_operations.dart';
import 'clipboard_controller.dart';
import '../state/explorer_state.dart';

/// Controls the Explorer feature.
///
/// Responsible for:
/// - Loading directories
/// - Managing loading state
/// - Managing errors
/// - Applying sorting
/// - Applying search filtering
class ExplorerController extends ChangeNotifier {
  ExplorerController(
    this._loadDirectoryUseCase,
    this._operations,
  );

  final LoadDirectoryUseCase _loadDirectoryUseCase;
  final ExplorerOperations _operations;

  ExplorerState _state = const ExplorerState();

  ExplorerState get state => _state;

  Future<void> openDirectory(String path) async {
    _state = _state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    notifyListeners();

    try {
      final directory = await _loadDirectoryUseCase(path);

      _state = _state.copyWith(
        directory: _processDirectory(directory),
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
      _state = _state.copyWith(
        directory: _processDirectory(directory),
      );
    }

    notifyListeners();
  }

  void setSearchQuery(String query) {
    _state = _state.copyWith(
      searchQuery: query,
    );

    final directory = _state.directory;

    if (directory != null) {
      _state = _state.copyWith(
        directory: _processDirectory(directory),
      );
    }

    notifyListeners();
  }

  Future<void> paste(
    ClipboardController clipboard,
  ) async {
    final directory = state.directory;

    if (directory == null) {
      return;
    }

    final clipboardState = clipboard.state;

    if (!clipboardState.hasData) {
      return;
    }

    if (clipboardState.isCopy) {
      await _operations.copyFiles(
        sourcePaths: clipboardState.paths,
        destinationPath: directory.path,
      );
    }

    if (clipboardState.isCut) {
      await _operations.moveFiles(
        sourcePaths: clipboardState.paths,
        destinationPath: directory.path,
      );

      clipboard.clear();
    }

    await openDirectory(directory.path);
  }

  Future<void> deleteFiles(
    List<String> sourcePaths,
  ) async {
    await _operations.deleteFiles(
      sourcePaths: sourcePaths,
    );

    final currentPath = _state.directory?.path;

    if (currentPath != null) {
      await openDirectory(currentPath);
    }
  }

  DirectoryEntity _processDirectory(
    DirectoryEntity directory,
  ) {
    final sortedItems = FileSortUtils.sort(
      directory.items,
      _state.sortOption,
    );

    final filteredItems = FileSearchUtils.filter(
      sortedItems,
      _state.searchQuery,
    );

    return DirectoryEntity(
      path: directory.path,
      name: directory.name,
      parentPath: directory.parentPath,
      items: filteredItems,
    );
  }

  Future<void> rename({
    required String sourcePath,
    required String newName,
  }) async {
    await _operations.rename(
      sourcePath: sourcePath,
      newName: newName,
    );

    final currentPath = _state.directory?.path;

    if (currentPath != null) {
      await openDirectory(currentPath);
    }
  }
}

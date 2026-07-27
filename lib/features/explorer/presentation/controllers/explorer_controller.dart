import 'package:flutter/foundation.dart';

import '../../domain/entities/directory_entity.dart';
import '../../domain/usecases/load_directory_usecase.dart';
import '../state/explorer_state.dart';

/// Controls the Explorer feature.
///
/// Responsible for:
/// - Loading directories
/// - Managing loading state
/// - Managing errors
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

      _state = _state.copyWith(
        directory: directory,
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
}

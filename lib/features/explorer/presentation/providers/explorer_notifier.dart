import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/load_directory_usecase.dart';
import '../state/explorer_state.dart';

class ExplorerNotifier extends StateNotifier<ExplorerState> {
  ExplorerNotifier(this._loadDirectory) : super(const ExplorerState());

  final LoadDirectoryUseCase _loadDirectory;

  Future<void> openFolder(String path) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final directory = await _loadDirectory(path);

      state = state.copyWith(
        directory: directory,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}

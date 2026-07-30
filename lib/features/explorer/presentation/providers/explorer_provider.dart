import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local_file_system_data_source.dart';
import '../../data/repositories/explorer_repository_impl.dart';
import '../../domain/usecases/load_directory_usecase.dart';
import 'explorer_notifier.dart';
import '../state/explorer_state.dart';

final explorerProvider =
    StateNotifierProvider<ExplorerNotifier, ExplorerState>((ref) {
  final repository = ExplorerRepositoryImpl(LocalFileSystemDataSource());

  return ExplorerNotifier(
    LoadDirectoryUseCase(repository),
  );
});

import '../../domain/entities/directory_entity.dart';

class ExplorerState {
  const ExplorerState({
    this.directory,
    this.isLoading = false,
    this.errorMessage,
  });

  final DirectoryEntity? directory;
  final bool isLoading;
  final String? errorMessage;

  ExplorerState copyWith({
    DirectoryEntity? directory,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ExplorerState(
      directory: directory ?? this.directory,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

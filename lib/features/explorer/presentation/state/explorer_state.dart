import '../../domain/entities/directory_entity.dart';

enum ExplorerStatus {
  initial,
  loading,
  loaded,
  empty,
  error,
}

class ExplorerState {
  const ExplorerState({
    this.status = ExplorerStatus.initial,
    this.currentPath = '',
    this.content,
    this.errorMessage,
  });

  final ExplorerStatus status;
  final String currentPath;
  final DirectoryEntity? content;
  final String? errorMessage;

  ExplorerState copyWith({
    ExplorerStatus? status,
    String? currentPath,
    DirectoryEntity? content,
    String? errorMessage,
  }) {
    return ExplorerState(
      status: status ?? this.status,
      currentPath: currentPath ?? this.currentPath,
      content: content ?? this.content,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

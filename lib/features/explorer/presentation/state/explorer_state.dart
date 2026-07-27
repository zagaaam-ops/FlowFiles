import '../../../../core/enums/sort_option.dart';
import '../../domain/entities/directory_entity.dart';

/// Represents the current UI state of the Explorer.
class ExplorerState {
  const ExplorerState({
    this.directory,
    this.isLoading = false,
    this.errorMessage,
    this.sortOption = SortOption.nameAscending,
  });

  final DirectoryEntity? directory;
  final bool isLoading;
  final String? errorMessage;

  /// Current sorting mode.
  final SortOption sortOption;

  ExplorerState copyWith({
    DirectoryEntity? directory,
    bool? isLoading,
    String? errorMessage,
    SortOption? sortOption,
  }) {
    return ExplorerState(
      directory: directory ?? this.directory,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}

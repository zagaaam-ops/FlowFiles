import 'package:flutter/foundation.dart';

/// Stores the current file selection.
@immutable
class SelectionState {
  const SelectionState({
    this.selectedPaths = const <String>{},
  });

  /// Paths of all selected files/folders.
  final Set<String> selectedPaths;

  /// Returns true if [path] is currently selected.
  bool isSelected(String path) {
    return selectedPaths.contains(path);
  }

  /// Number of selected items.
  int get count => selectedPaths.length;

  /// Returns true when nothing is selected.
  bool get isEmpty => selectedPaths.isEmpty;

  /// Returns true when at least one item is selected.
  bool get isNotEmpty => selectedPaths.isNotEmpty;

  SelectionState copyWith({
    Set<String>? selectedPaths,
  }) {
    return SelectionState(
      selectedPaths: selectedPaths ?? this.selectedPaths,
    );
  }
}

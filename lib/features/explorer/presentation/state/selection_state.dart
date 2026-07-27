import 'package:flutter/foundation.dart';

/// Stores the current file selection.
@immutable
class SelectionState {
  const SelectionState({
    this.selectedPaths = const <String>{},
  });

  final Set<String> selectedPaths;

  bool isSelected(String path) {
    return selectedPaths.contains(path);
  }

  SelectionState copyWith({
    Set<String>? selectedPaths,
  }) {
    return SelectionState(
      selectedPaths: selectedPaths ?? this.selectedPaths,
    );
  }
}

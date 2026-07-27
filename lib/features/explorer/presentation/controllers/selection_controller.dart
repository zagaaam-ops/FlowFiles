import 'package:flutter/foundation.dart';

import '../state/selection_state.dart';

/// Controls file/folder selection.
class SelectionController extends ChangeNotifier {
  SelectionState _state = const SelectionState();

  SelectionState get state => _state;

  /// Selects or deselects a path.
  void toggleSelection(String path) {
    final selected = Set<String>.from(_state.selectedPaths);

    if (selected.contains(path)) {
      selected.remove(path);
    } else {
      selected.add(path);
    }

    _state = _state.copyWith(
      selectedPaths: selected,
    );

    notifyListeners();
  }

  /// Clears the current selection.
  void clearSelection() {
    _state = const SelectionState();
    notifyListeners();
  }

  /// Returns true if the path is selected.
  bool isSelected(String path) {
    return _state.isSelected(path);
  }

  /// Number of selected items.
  int get selectedCount => _state.count;
}

import 'package:flutter/foundation.dart';

import '../state/selection_state.dart';

/// Controls file/folder selection.
class SelectionController extends ChangeNotifier {
  SelectionState _state = const SelectionState();

  SelectionState get state => _state;

  /// Returns all selected file/folder paths.
  List<String> get selectedPaths => _state.selectedPaths.toList();

  bool isSelected(String path) {
    return _state.isSelected(path);
  }

  int get selectedCount => _state.count;

  bool get hasSelection => _state.isNotEmpty;

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

  /// Select one item only.
  void selectOnly(String path) {
    _state = SelectionState(
      selectedPaths: {path},
    );

    notifyListeners();
  }

  /// Clear all selected items.
  void clearSelection() {
    _state = const SelectionState();

    notifyListeners();
  }

  /// Select all items.
  void selectAll(Iterable<String> paths) {
    _state = SelectionState(
      selectedPaths: paths.toSet(),
    );

    notifyListeners();
  }
}

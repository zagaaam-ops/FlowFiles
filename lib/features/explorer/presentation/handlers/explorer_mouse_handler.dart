import 'package:flutter/services.dart';

import '../controllers/selection_controller.dart';

/// Handles all mouse interactions for the Explorer.
///
/// UI widgets call this class instead of directly modifying
/// the SelectionController.
class ExplorerMouseHandler {
  ExplorerMouseHandler({
    required this.selectionController,
  });

  final SelectionController selectionController;

  /// Handles left-click selection.
  void handleItemTap(String path) {
    final bool isCtrlPressed = HardwareKeyboard.instance.isControlPressed;

    if (isCtrlPressed) {
      selectionController.toggleSelection(path);
    } else {
      selectionController.selectOnly(path);
    }
  }

  /// Handles right-click selection.
  ///
  /// Before showing the context menu, ensure the clicked
  /// item becomes selected if it wasn't already.
  void handleRightClick(String path) {
    if (!selectionController.isSelected(path)) {
      selectionController.selectOnly(path);
    }
  }
}

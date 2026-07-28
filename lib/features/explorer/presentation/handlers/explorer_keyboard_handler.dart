import 'package:flutter/services.dart';

import '../../domain/entities/file_entity.dart';
import '../controllers/explorer_controller.dart';
import '../controllers/selection_controller.dart';

/// Handles all keyboard shortcuts for the Explorer.
///
/// This class contains no UI code.
/// It only reacts to keyboard events.
class ExplorerKeyboardHandler {
  ExplorerKeyboardHandler({
    required this.explorerController,
    required this.selectionController,
  });

  final ExplorerController explorerController;
  final SelectionController selectionController;

  void handle(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }

    // ESC → Clear selection
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      selectionController.clearSelection();
      return;
    }

    final bool isCtrlPressed = HardwareKeyboard.instance.isControlPressed;

    // Ctrl + A → Select all items
    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyA) {
      final items = explorerController.state.directory?.items ?? <FileEntity>[];

      selectionController.selectAll(
        items.map((item) => item.path),
      );
    }
  }
}

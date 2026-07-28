import 'package:flutter/material.dart';

enum ExplorerMenuAction {
  open,
  rename,
  copy,
  cut,
  delete,
  properties,
}

class ExplorerContextMenu {
  static Future<ExplorerMenuAction?> show(
    BuildContext context,
    Offset position,
  ) {
    return showMenu<ExplorerMenuAction>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: const [
        PopupMenuItem(
          value: ExplorerMenuAction.open,
          child: Text('Open'),
        ),
        PopupMenuItem(
          value: ExplorerMenuAction.rename,
          child: Text('Rename'),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: ExplorerMenuAction.copy,
          child: Text('Copy'),
        ),
        PopupMenuItem(
          value: ExplorerMenuAction.cut,
          child: Text('Cut'),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: ExplorerMenuAction.delete,
          child: Text('Delete'),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: ExplorerMenuAction.properties,
          child: Text('Properties'),
        ),
      ],
    );
  }
}

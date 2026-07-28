import 'package:flutter/material.dart';

import '../../domain/entities/file_entity.dart';
import '../controllers/selection_controller.dart';
import '../handlers/explorer_mouse_handler.dart';
import 'file_tile.dart';
import 'folder_tile.dart';

class ExplorerList extends StatelessWidget {
  const ExplorerList({
    super.key,
    required this.items,
    required this.selectionController,
    required this.mouseHandler,
  });

  final List<FileEntity> items;
  final SelectionController selectionController;
  final ExplorerMouseHandler mouseHandler;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text('This folder is empty.'),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        if (item.isDirectory) {
          return FolderTile(
            folder: item,
            selected: selectionController.isSelected(item.path),
            onTap: () => mouseHandler.handleItemTap(item.path),
          );
        }

        return FileTile(
          file: item,
          selected: selectionController.isSelected(item.path),
          onTap: () => mouseHandler.handleItemTap(item.path),
        );
      },
    );
  }
}

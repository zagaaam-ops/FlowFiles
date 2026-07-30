import 'package:flutter/material.dart';

enum CreateMenuAction {
  folder,
  file,
}

class CreateMenuButton extends StatelessWidget {
  const CreateMenuButton({
    super.key,
    required this.onSelected,
  });

  final ValueChanged<CreateMenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CreateMenuAction>(
      tooltip: 'Create',
      icon: const Icon(Icons.add),
      onSelected: onSelected,
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: CreateMenuAction.folder,
          child: Row(
            children: [
              Icon(Icons.create_new_folder),
              SizedBox(width: 12),
              Text('New Folder'),
            ],
          ),
        ),
        PopupMenuItem(
          value: CreateMenuAction.file,
          child: Row(
            children: [
              Icon(Icons.insert_drive_file_outlined),
              SizedBox(width: 12),
              Text('Empty File'),
            ],
          ),
        ),
      ],
    );
  }
}

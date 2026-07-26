import 'package:flutter/material.dart';

import '../../../../app/di/service_locator.dart';
import '../../domain/entities/file_entity.dart';
import '../widgets/file_tile.dart';
import '../widgets/folder_tile.dart';

/// Main Explorer screen.
///
/// This is the first screen of FlowFiles.
/// It will later load real folders from the ExplorerController.
class ExplorerPage extends StatelessWidget {
  const ExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the controller from the Service Locator.
    // It will be used in upcoming commits to load real data.
    final controller = ServiceLocator.explorerController;

    // Ignore warning for now. We will use it in the next commits.
    // ignore: unused_local_variable
    final _ = controller;

    // Temporary sample data until the file system is connected.
    final items = <FileEntity>[
      FileEntity(
        path: '/Documents',
        name: 'Documents',
        isDirectory: true,
        size: 0,
        lastModified: DateTime.now(),
        extension: '',
      ),
      FileEntity(
        path: '/Downloads',
        name: 'Downloads',
        isDirectory: true,
        size: 0,
        lastModified: DateTime.now(),
        extension: '',
      ),
      FileEntity(
        path: '/Report.pdf',
        name: 'Report.pdf',
        isDirectory: false,
        size: 245760,
        lastModified: DateTime.now(),
        extension: 'pdf',
      ),
      FileEntity(
        path: '/Budget.xlsx',
        name: 'Budget.xlsx',
        isDirectory: false,
        size: 102400,
        lastModified: DateTime.now(),
        extension: 'xlsx',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlowFiles'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          if (item.isDirectory) {
            return FolderTile(
              folder: item,
              onTap: () {
                // Folder navigation will be implemented later.
              },
            );
          }

          return FileTile(
            file: item,
            onTap: () {
              // File selection will be implemented later.
            },
          );
        },
      ),
    );
  }
}

import '../../../../app/di/service_locator.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/file_entity.dart';
import '../widgets/file_tile.dart';
import '../widgets/folder_tile.dart';

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          if (item.isDirectory) {
            return FolderTile(folder: item);
          }

          return FileTile(file: item);
        },
      ),
    );
  }
}

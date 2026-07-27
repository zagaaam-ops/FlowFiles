import 'package:flutter/material.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../core/utils/path_utils.dart';
import '../../domain/entities/file_entity.dart';
import '../controllers/explorer_controller.dart';
import '../widgets/file_tile.dart';
import '../widgets/folder_tile.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({super.key});

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  late final ExplorerController controller;

  @override
  void initState() {
    super.initState();

    controller = ServiceLocator.explorerController;

    controller.addListener(_refresh);

    controller.openDirectory(
      PathUtils.getHomeDirectory(),
    );
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.state;

    if (state.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('FlowFiles'),
        ),
        body: Center(
          child: Text(state.errorMessage!),
        ),
      );
    }

    final items = state.directory?.items ?? <FileEntity>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.directory?.path ?? 'FlowFiles',
        ),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'This folder is empty',
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                if (item.isDirectory) {
                  return FolderTile(
                    folder: item,
                    onTap: () {
                      controller.openDirectory(item.path);
                    },
                  );
                }

                return FileTile(
                  file: item,
                  onTap: () {},
                );
              },
            ),
    );
  }
}

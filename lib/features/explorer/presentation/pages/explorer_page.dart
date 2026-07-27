import 'package:flutter/material.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../core/utils/path_utils.dart';
import '../../domain/entities/file_entity.dart';
import '../controllers/explorer_controller.dart';
import '../widgets/explorer_toolbar.dart';
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ExplorerToolbar(
              currentPath: state.directory?.path ?? '',
              currentSort: state.sortOption,
              onHome: () {
                controller.openDirectory(
                  PathUtils.getHomeDirectory(),
                );
              },
              onUp: () {
                final parent = state.directory?.parentPath;

                if (parent != null && parent.isNotEmpty) {
                  controller.openDirectory(parent);
                }
              },
              onRefresh: () {
                final path = state.directory?.path;

                if (path != null) {
                  controller.openDirectory(path);
                }
              },
              onNavigate: (path) {
                controller.openDirectory(path);
              },
              onSortChanged: (option) {
                controller.setSortOption(option);
              },
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.errorMessage != null) {
                    return Center(
                      child: Text(state.errorMessage!),
                    );
                  }

                  final items =
                      state.directory?.items ?? <FileEntity>[];

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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

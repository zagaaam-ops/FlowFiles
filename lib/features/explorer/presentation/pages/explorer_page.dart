import 'package:flutter/material.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../core/utils/path_utils.dart';
import '../../domain/entities/file_entity.dart';
import '../controllers/explorer_controller.dart';
import '../controllers/selection_controller.dart';
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
  late final SelectionController selectionController;

  /// Receives keyboard focus for the Explorer.
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller = ServiceLocator.explorerController;
    selectionController = ServiceLocator.selectionController;

    controller.addListener(_refresh);
    selectionController.addListener(_refresh);

    controller.openDirectory(
      PathUtils.getHomeDirectory(),
    );

    // Automatically focus the Explorer after it appears.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);
    selectionController.removeListener(_refresh);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.state;

    return Scaffold(
      body: SafeArea(
        child: Focus(
          focusNode: _focusNode,
          autofocus: true,
          child: Column(
            children: [
              ExplorerToolbar(
                currentPath: state.directory?.path ?? '',
                currentSort: state.sortOption,
                searchQuery: state.searchQuery,
                selectedCount: selectionController.selectedCount,
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
                onSearchChanged: (query) {
                  controller.setSearchQuery(query);
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
                            selected: selectionController.isSelected(item.path),
                            onTap: () {
                              selectionController.toggleSelection(item.path);
                            },
                          );
                        }

                        return FileTile(
                          file: item,
                          selected: selectionController.isSelected(item.path),
                          onTap: () {
                            selectionController.toggleSelection(item.path);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

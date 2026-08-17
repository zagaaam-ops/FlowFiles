import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../core/services/file_opener_service.dart';
import '../../../../core/utils/path_utils.dart';
import '../../domain/entities/file_entity.dart';
import '../../domain/usecases/delete_files_usecase.dart';
import '../../domain/usecases/rename_file_usecase.dart';
import '../controllers/clipboard_controller.dart';
import '../state/clipboard_state.dart';
import '../controllers/explorer_controller.dart';
import '../controllers/selection_controller.dart';
import '../widgets/explorer_context_menu.dart';
import '../widgets/explorer_toolbar.dart';
import '../widgets/file_tile.dart';
import '../widgets/folder_tile.dart';

class ExplorerPage extends StatefulWidget {
  const ExplorerPage({
    super.key,
    this.controller,
    this.selectionController,
    this.deleteFilesUseCase,
    this.renameFileUseCase,
    this.clipboardController,
    this.fileOpenerService,
  });

  final ExplorerController? controller;
  final SelectionController? selectionController;
  final DeleteFilesUseCase? deleteFilesUseCase;
  final RenameFileUseCase? renameFileUseCase;
  final ClipboardController? clipboardController;
  final FileOpenerService? fileOpenerService;

  @override
  State<ExplorerPage> createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  late final ExplorerController controller;
  late final SelectionController selectionController;
  late final DeleteFilesUseCase deleteFilesUseCase;
  late final RenameFileUseCase renameFileUseCase;
  late final ClipboardController clipboardController;
  late final FileOpenerService fileOpenerService;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? ServiceLocator.explorerController;
    selectionController =
        widget.selectionController ?? ServiceLocator.selectionController;

    deleteFilesUseCase =
        widget.deleteFilesUseCase ?? ServiceLocator.deleteFilesUseCase;

    renameFileUseCase =
        widget.renameFileUseCase ?? ServiceLocator.renameFileUseCase;

    clipboardController =
        widget.clipboardController ?? ServiceLocator.clipboardController;

    fileOpenerService =
        widget.fileOpenerService ?? ServiceLocator.fileOpenerService;

    controller.addListener(_refresh);
    selectionController.addListener(_refresh);

    if (widget.controller == null) {
      controller.openDirectory(
        PathUtils.getHomeDirectory(),
      );
    }

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

  Future<void> _openFile(String path) async {
    try {
      await fileOpenerService.open(path);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to open file: $e'),
        ),
      );
    }
  }

  Future<void> _showContextMenu(
    BuildContext context,
    String path,
    Offset position,
  ) async {
    if (!selectionController.isSelected(path)) {
      selectionController.selectOnly(path);
    }

    final action = await ExplorerContextMenu.show(
      context,
      position,
    );

    if (!mounted || action == null) {
      return;
    }

    switch (action) {
      case ExplorerMenuAction.open:
        break;
      case ExplorerMenuAction.rename:
        await _renameSelectedItem();
        break;
      case ExplorerMenuAction.copy:
        clipboardController.copy(
          selectionController.state.selectedPaths.toList(),
        );
        break;
      case ExplorerMenuAction.cut:
        clipboardController.cut(
          selectionController.state.selectedPaths.toList(),
        );
        break;
      case ExplorerMenuAction.paste:
        await _pasteClipboard();
        break;
      case ExplorerMenuAction.delete:
        await _deleteSelectedItems();
        break;
      case ExplorerMenuAction.properties:
        break;
    }
  }

  Future<void> _pasteClipboard() async {
    final clipboard = clipboardController.state;

    if (!clipboard.hasData) {
      return;
    }

    final destinationPath = controller.state.directory?.path;

    if (destinationPath == null || destinationPath.isEmpty) {
      return;
    }

    final paths = List<String>.from(clipboard.paths);

    if (clipboard.operation == ClipboardOperation.copy) {
      await ServiceLocator.copyFilesUseCase(
        sourcePaths: paths,
        destinationPath: destinationPath,
      );
    } else if (clipboard.operation == ClipboardOperation.cut) {
      await ServiceLocator.moveFilesUseCase(
        sourcePaths: paths,
        destinationPath: destinationPath,
      );

      clipboardController.clear();
    }

    if (!mounted) {
      return;
    }

    selectionController.clearSelection();

    await controller.openDirectory(destinationPath);
  }

  Future<void> _renameSelectedItem() async {
    final paths = selectionController.state.selectedPaths.toList();

    if (paths.length != 1) {
      return;
    }

    final sourcePath = paths.first;
    final currentName = sourcePath.split('/').last;

    final textController = TextEditingController(
      text: currentName,
    );

    final newName = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Rename'),
          content: TextField(
            controller: textController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'New name',
            ),
            onSubmitted: (value) {
              final trimmed = value.trim();

              if (trimmed.isNotEmpty) {
                Navigator.of(dialogContext).pop(trimmed);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final trimmed = textController.text.trim();

                if (trimmed.isNotEmpty) {
                  Navigator.of(dialogContext).pop(trimmed);
                }
              },
              child: const Text('Rename'),
            ),
          ],
        );
      },
    );

    textController.dispose();

    if (!mounted || newName == null || newName.isEmpty) {
      return;
    }

    if (newName == currentName) {
      return;
    }

    try {
      await renameFileUseCase(
        sourcePath: sourcePath,
        newName: newName,
      );

      if (!mounted) {
        return;
      }

      selectionController.clearSelection();

      final directoryPath = controller.state.directory?.path;

      if (directoryPath != null && directoryPath.isNotEmpty) {
        await controller.openDirectory(directoryPath);
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to rename item: $e'),
        ),
      );
    }
  }

  Future<void> _deleteSelectedItems() async {
    final paths = selectionController.state.selectedPaths.toList();

    if (paths.isEmpty) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final count = paths.length;

        return AlertDialog(
          title: const Text('Delete items?'),
          content: Text(
            count == 1
                ? 'Are you sure you want to delete the selected item?'
                : 'Are you sure you want to delete $count selected items?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) {
      return;
    }

    await deleteFilesUseCase(
      paths: paths,
    );

    if (!mounted) {
      return;
    }

    selectionController.clearSelection();

    final currentPath = controller.state.directory?.path;

    if (currentPath != null && currentPath.isNotEmpty) {
      await controller.openDirectory(currentPath);
    }
  }

  /// Handles keyboard shortcuts.
  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }

    if (event.logicalKey == LogicalKeyboardKey.escape) {
      selectionController.clearSelection();
      return;
    }

    final bool isCtrlPressed = HardwareKeyboard.instance.isControlPressed;

    if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyA) {
      final items = controller.state.directory?.items ?? <FileEntity>[];

      selectionController.selectAll(
        items.map((item) => item.path),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.state;

    return Scaffold(
      body: SafeArea(
        child: KeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKeyEvent: _handleKeyEvent,
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
                        child: Text(
                          state.errorMessage!,
                        ),
                      );
                    }

                    final items = state.directory?.items ?? <FileEntity>[];

                    if (items.isEmpty) {
                      return const Center(
                        child: Text(
                          'This folder is empty.',
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        if (item.isDirectory) {
                          return FolderTile(
                            folder: item,
                            selected: selectionController.isSelected(
                              item.path,
                            ),
                            onTap: () {
                              selectionController.selectOnly(
                                item.path,
                              );
                            },
                            onDoubleTap: () {
                              controller.openDirectory(item.path);
                            },
                            onSecondaryTapDown: (details) {
                              _showContextMenu(
                                context,
                                item.path,
                                details.globalPosition,
                              );
                            },
                          );
                        }

                        return FileTile(
                          file: item,
                          selected: selectionController.isSelected(
                            item.path,
                          ),
                          onTap: () {
                            selectionController.selectOnly(
                              item.path,
                            );
                          },
                          onDoubleTap: () {
                            _openFile(item.path);
                          },
                          onSecondaryTapDown: (details) {
                            _showContextMenu(
                              context,
                              item.path,
                              details.globalPosition,
                            );
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

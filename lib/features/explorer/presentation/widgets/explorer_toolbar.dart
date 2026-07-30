import 'package:flutter/material.dart';

import '../../../../core/enums/sort_option.dart';
import 'breadcrumb_bar.dart';
import 'create_menu_button.dart';

class ExplorerToolbar extends StatefulWidget {
  const ExplorerToolbar({
    super.key,
    required this.currentPath,
    required this.currentSort,
    required this.searchQuery,
    required this.selectedCount,
    this.onHome,
    this.onUp,
    this.onRefresh,
    this.onNewFolder,
    this.onNewFile,
    this.onNavigate,
    this.onSortChanged,
    this.onSearchChanged,
  });

  final String currentPath;
  final SortOption currentSort;
  final String searchQuery;
  final int selectedCount;

  final VoidCallback? onHome;
  final VoidCallback? onUp;
  final VoidCallback? onRefresh;
  final VoidCallback? onNewFolder;
  final VoidCallback? onNewFile;

  final ValueChanged<String>? onNavigate;
  final ValueChanged<SortOption>? onSortChanged;
  final ValueChanged<String>? onSearchChanged;

  @override
  State<ExplorerToolbar> createState() => _ExplorerToolbarState();
}

class _ExplorerToolbarState extends State<ExplorerToolbar> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(
      text: widget.searchQuery,
    );
  }

  @override
  void didUpdateWidget(covariant ExplorerToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.searchQuery != _searchController.text) {
      _searchController.text = widget.searchQuery;

      _searchController.selection = TextSelection.fromPosition(
        TextPosition(
          offset: _searchController.text.length,
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.selectedCount == 0
        ? 'FlowFiles'
        : widget.selectedCount == 1
            ? '1 item selected'
            : '${widget.selectedCount} items selected';

    return Material(
      elevation: 2,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Home',
                  onPressed: widget.onHome,
                  icon: const Icon(Icons.home),
                ),
                IconButton(
                  tooltip: 'Up',
                  onPressed: widget.onUp,
                  icon: const Icon(Icons.arrow_upward),
                ),
                IconButton(
                  tooltip: 'Refresh',
                  onPressed: widget.onRefresh,
                  icon: const Icon(Icons.refresh),
                ),
                CreateMenuButton(
                  onSelected: (action) {
                    switch (action) {
                      case CreateMenuAction.folder:
                        widget.onNewFolder?.call();
                        break;
                      case CreateMenuAction.file:
                        widget.onNewFile?.call();
                        break;
                    }
                  },
                ),
                PopupMenuButton<SortOption>(
                  initialValue: widget.currentSort,
                  onSelected: widget.onSortChanged,
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: SortOption.nameAscending,
                      child: Text('Name (A–Z)'),
                    ),
                    PopupMenuItem(
                      value: SortOption.nameDescending,
                      child: Text('Name (Z–A)'),
                    ),
                    PopupMenuItem(
                      value: SortOption.dateNewest,
                      child: Text('Date (Newest)'),
                    ),
                    PopupMenuItem(
                      value: SortOption.dateOldest,
                      child: Text('Date (Oldest)'),
                    ),
                    PopupMenuItem(
                      value: SortOption.sizeLargest,
                      child: Text('Size (Largest)'),
                    ),
                    PopupMenuItem(
                      value: SortOption.sizeSmallest,
                      child: Text('Size (Smallest)'),
                    ),
                    PopupMenuItem(
                      value: SortOption.type,
                      child: Text('File Type'),
                    ),
                  ],
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.sort),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            BreadcrumbBar(
              path: widget.currentPath,
              onSegmentTap: widget.onNavigate,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search files and folders...',
                border: OutlineInputBorder(),
              ),
              onChanged: widget.onSearchChanged,
            ),
          ],
        ),
      ),
    );
  }
}

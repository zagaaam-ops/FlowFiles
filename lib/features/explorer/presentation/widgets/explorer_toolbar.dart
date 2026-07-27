import 'package:flutter/material.dart';

import '../../../../core/enums/sort_option.dart';
import 'breadcrumb_bar.dart';

class ExplorerToolbar extends StatelessWidget {
  const ExplorerToolbar({
    super.key,
    required this.currentPath,
    required this.currentSort,
    required this.searchQuery,
    this.onHome,
    this.onUp,
    this.onRefresh,
    this.onNavigate,
    this.onSortChanged,
    this.onSearchChanged,
  });

  final String currentPath;
  final SortOption currentSort;
  final String searchQuery;

  final VoidCallback? onHome;
  final VoidCallback? onUp;
  final VoidCallback? onRefresh;

  final ValueChanged<String>? onNavigate;
  final ValueChanged<SortOption>? onSortChanged;
  final ValueChanged<String>? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  tooltip: 'Home',
                  onPressed: onHome,
                  icon: const Icon(Icons.home),
                ),
                IconButton(
                  tooltip: 'Up',
                  onPressed: onUp,
                  icon: const Icon(Icons.arrow_upward),
                ),
                IconButton(
                  tooltip: 'Refresh',
                  onPressed: onRefresh,
                  icon: const Icon(Icons.refresh),
                ),
                const Spacer(),
                PopupMenuButton<SortOption>(
                  initialValue: currentSort,
                  onSelected: onSortChanged,
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
              path: currentPath,
              onSegmentTap: onNavigate,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: searchQuery)
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: searchQuery.length),
                ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search files and folders...',
                border: OutlineInputBorder(),
              ),
              onChanged: onSearchChanged,
            ),
          ],
        ),
      ),
    );
  }
}

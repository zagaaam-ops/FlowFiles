import 'package:flutter/material.dart';

import 'breadcrumb_bar.dart';

class ExplorerToolbar extends StatelessWidget {
  const ExplorerToolbar({
    super.key,
    required this.currentPath,
    this.onHome,
    this.onUp,
    this.onRefresh,
    this.onNavigate,
  });

  final String currentPath;

  final VoidCallback? onHome;
  final VoidCallback? onUp;
  final VoidCallback? onRefresh;

  /// Called when a breadcrumb segment is tapped.
  final ValueChanged<String>? onNavigate;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
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
              ],
            ),
            const SizedBox(height: 8),
            BreadcrumbBar(
              path: currentPath,
              onSegmentTap: onNavigate,
            ),
          ],
        ),
      ),
    );
  }
}

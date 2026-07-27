import 'package:flutter/material.dart';

class ExplorerToolbar extends StatelessWidget {
  const ExplorerToolbar({
    super.key,
    required this.currentPath,
    this.onHome,
    this.onUp,
    this.onRefresh,
  });

  final String currentPath;

  final VoidCallback? onHome;
  final VoidCallback? onUp;
  final VoidCallback? onRefresh;

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
        child: Row(
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
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  currentPath,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

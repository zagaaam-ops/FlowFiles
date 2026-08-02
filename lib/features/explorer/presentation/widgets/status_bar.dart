import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    super.key,
    required this.itemCount,
    required this.selectedCount,
    required this.totalSize,
  });

  final int itemCount;
  final int selectedCount;
  final int totalSize;

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';

    const units = ['KB', 'MB', 'GB', 'TB'];

    double size = bytes.toDouble();
    int unit = -1;

    while (size >= 1024 && unit < units.length - 1) {
      size /= 1024;
      unit++;
    }

    return '${size.toStringAsFixed(1)} ${units[unit]}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Text('📁 $itemCount Items'),
          const SizedBox(width: 20),
          Text('✔ $selectedCount Selected'),
          const Spacer(),
          Text('💾 ${_formatBytes(totalSize)}'),
        ],
      ),
    );
  }
}

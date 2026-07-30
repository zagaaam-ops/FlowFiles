import 'package:flutter/material.dart';

class BreadcrumbBar extends StatelessWidget {
  const BreadcrumbBar({
    super.key,
    required this.path,
    this.onSegmentTap,
  });

  final String path;
  final ValueChanged<String>? onSegmentTap;

  @override
  Widget build(BuildContext context) {
    final segments =
        path.split(RegExp(r'[\\/]+')).where((e) => e.isNotEmpty).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () => onSegmentTap?.call('/'),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 4,
              ),
              child: Row(
                children: [
                  Icon(Icons.home, size: 18),
                  SizedBox(width: 4),
                  Text('Home'),
                ],
              ),
            ),
          ),
          for (int i = 0; i < segments.length; i++) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                Icons.chevron_right,
                size: 18,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () {
                final target = segments.take(i + 1).join('/');
                onSegmentTap?.call('/$target');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 4,
                ),
                child: Text(
                  segments[i],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

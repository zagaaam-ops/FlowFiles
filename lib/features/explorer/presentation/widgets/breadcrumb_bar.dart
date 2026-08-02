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
    final separator = path.contains('\\') ? '\\' : '/';

    final parts = path.split(separator).where((e) => e.isNotEmpty).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () => onSegmentTap?.call(separator),
              child: const Row(
                children: [
                  Icon(Icons.home, size: 18),
                  SizedBox(width: 4),
                  Text('Home'),
                ],
              ),
            ),
            for (int i = 0; i < parts.length; i++) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  Icons.chevron_right,
                  size: 18,
                ),
              ),
              InkWell(
                onTap: onSegmentTap == null
                    ? null
                    : () {
                        final root = separator == "\\" ? parts.first : "";
                        final subPath = separator == "\\"
                            ? root +
                                separator +
                                parts.skip(1).take(i).join(separator) +
                                (i > 0 ? separator : "")
                            : separator + parts.take(i + 1).join(separator);
                        onSegmentTap!(subPath);
                      },
                child: Text(
                  parts[i],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

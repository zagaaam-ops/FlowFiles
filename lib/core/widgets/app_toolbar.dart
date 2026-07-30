import 'package:flutter/material.dart';

import '../constants/app_strings.dart';

class AppToolbar extends StatelessWidget implements PreferredSizeWidget {
  const AppToolbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.appName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            AppStrings.appTagline,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
          tooltip: "Search",
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
          tooltip: "Settings",
        ),
      ],
    );
  }
}

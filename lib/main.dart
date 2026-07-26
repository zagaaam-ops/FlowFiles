import 'package:flutter/material.dart';

import 'features/explorer/presentation/pages/explorer_page.dart';

void main() {
  runApp(const FlowFilesApp());
}

class FlowFilesApp extends StatelessWidget {
  const FlowFilesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlowFiles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ExplorerPage(),
    );
  }
}

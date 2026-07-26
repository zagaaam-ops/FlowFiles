import 'package:flutter/material.dart';

/// First screen of the Explorer Engine.
///
/// This page will later display:
/// - Current directory
/// - Files
/// - Folders
/// - Organizer Mode
/// - Split View
class ExplorerPage extends StatelessWidget {
  const ExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlowFiles'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Explorer Engine\nComing Alive...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

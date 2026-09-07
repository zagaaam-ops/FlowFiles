import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DestinationPanel extends StatefulWidget {
  const DestinationPanel({super.key});

  @override
  State<DestinationPanel> createState() => _DestinationPanelState();
}

class _DestinationPanelState extends State<DestinationPanel> {
  String? _destinationPath;

  Future<void> _chooseFolder() async {
    final path = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Choose destination folder',
    );

    if (!mounted || path == null || path.isEmpty) {
      return;
    }

    setState(() {
      _destinationPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Destination',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.drive_folder_upload,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _destinationPath ?? 'No destination selected',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _chooseFolder,
                    icon: const Icon(Icons.folder_open),
                    label: const Text('Choose Folder'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

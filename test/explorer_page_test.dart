import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/features/explorer/data/datasources/local_file_system_data_source.dart';
import 'package:fast_file_organizer/features/explorer/data/repositories/explorer_repository_impl.dart';
import 'package:fast_file_organizer/features/explorer/domain/usecases/load_directory_usecase.dart';
import 'package:fast_file_organizer/features/explorer/presentation/controllers/explorer_controller.dart';
import 'package:fast_file_organizer/features/explorer/presentation/controllers/selection_controller.dart';
import 'package:fast_file_organizer/features/explorer/presentation/pages/explorer_page.dart';

void main() {
  late Directory tempDirectory;
  late ExplorerController controller;
  late SelectionController selectionController;

  setUp(() {
    tempDirectory =
        Directory.systemTemp.createTempSync('flowfiles_page_test_');

    File('${tempDirectory.path}/alpha.txt')
        .writeAsStringSync('alpha');

    File('${tempDirectory.path}/beta.txt')
        .writeAsStringSync('beta');

    final repository = ExplorerRepositoryImpl(
      LocalFileSystemDataSource(),
    );

    controller = ExplorerController(
      LoadDirectoryUseCase(repository),
    );

    selectionController = SelectionController();
  });

  tearDown(() {
    if (tempDirectory.existsSync()) {
      tempDirectory.deleteSync(recursive: true);
    }
  });

  testWidgets(
    'ExplorerPage displays files from a real directory',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ExplorerPage(
            controller: controller,
            selectionController: selectionController,
          ),
        ),
      );

      await controller.openDirectory(tempDirectory.path);

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('alpha.txt'), findsOneWidget);
      expect(find.text('beta.txt'), findsOneWidget);
    },
  );
}

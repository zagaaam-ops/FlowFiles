import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/features/explorer/data/datasources/local_file_system_data_source.dart';
import 'package:fast_file_organizer/features/explorer/data/repositories/explorer_repository_impl.dart';
import 'package:fast_file_organizer/features/explorer/domain/usecases/load_directory_usecase.dart';
import 'package:fast_file_organizer/features/explorer/presentation/controllers/explorer_controller.dart';

void main() {
  late Directory tempDirectory;
  late ExplorerController controller;

  setUp(() {
    tempDirectory =
        Directory.systemTemp.createTempSync('flowfiles_controller_test_');

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
  });

  tearDown(() {
    if (tempDirectory.existsSync()) {
      tempDirectory.deleteSync(recursive: true);
    }
  });

  test(
    'loads files from a real directory',
    () async {
      await controller.openDirectory(tempDirectory.path);

      final directory = controller.state.directory;

      expect(directory, isNotNull);
      expect(
        directory!.items.map((item) => item.name),
        containsAll([
          'alpha.txt',
          'beta.txt',
        ]),
      );
    },
  );
}

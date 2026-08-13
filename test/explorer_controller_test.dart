import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/features/explorer/data/datasources/local_file_system_data_source.dart';
import 'package:fast_file_organizer/features/explorer/data/repositories/explorer_repository_impl.dart';
import 'package:fast_file_organizer/features/explorer/domain/usecases/load_directory_usecase.dart';
import 'package:fast_file_organizer/features/explorer/presentation/controllers/explorer_controller.dart';

void main() {
  test(
    'ExplorerController loads a directory',
    () async {
      final tempDirectory =
          Directory.systemTemp.createTempSync('flowfiles_controller_test_');

      try {
        File('${tempDirectory.path}/alpha.txt').writeAsStringSync('alpha');

        File('${tempDirectory.path}/beta.txt').writeAsStringSync('beta');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final controller = ExplorerController(
          LoadDirectoryUseCase(repository),
        );

        await controller.openDirectory(tempDirectory.path);

        expect(controller.state.directory, isNotNull);
        expect(controller.state.directory!.items.length, 2);
        expect(
          controller.state.directory!.items.map((item) => item.name),
          containsAll(<String>[
            'alpha.txt',
            'beta.txt',
          ]),
        );
      } finally {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      }
    },
  );
}

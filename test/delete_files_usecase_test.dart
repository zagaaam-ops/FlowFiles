import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/features/explorer/data/datasources/local_file_system_data_source.dart';
import 'package:fast_file_organizer/features/explorer/data/repositories/explorer_repository_impl.dart';
import 'package:fast_file_organizer/features/explorer/domain/usecases/delete_files_usecase.dart';

void main() {
  test(
    'DeleteFilesUseCase deletes files and directories',
    () async {
      final tempDirectory =
          Directory.systemTemp.createTempSync('flowfiles_delete_test_');

      try {
        final file = File('${tempDirectory.path}/alpha.txt');
        file.writeAsStringSync('alpha');

        final folder = Directory('${tempDirectory.path}/documents');

        folder.createSync();

        final nestedFile = File('${folder.path}/nested.txt');

        nestedFile.writeAsStringSync('nested');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final useCase = DeleteFilesUseCase(repository);

        await useCase(
          paths: <String>[
            file.path,
            folder.path,
          ],
        );

        expect(await file.exists(), isFalse);
        expect(await folder.exists(), isFalse);
        expect(await nestedFile.exists(), isFalse);
      } finally {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      }
    },
  );
}

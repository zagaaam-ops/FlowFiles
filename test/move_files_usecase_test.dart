import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/features/explorer/data/datasources/local_file_system_data_source.dart';
import 'package:fast_file_organizer/features/explorer/data/repositories/explorer_repository_impl.dart';
import 'package:fast_file_organizer/features/explorer/domain/usecases/move_files_usecase.dart';

void main() {
  test(
    'MoveFilesUseCase moves a file to the destination directory',
    () async {
      final sourceDirectory =
          Directory.systemTemp.createTempSync('flowfiles_move_source_');
      final destinationDirectory =
          Directory.systemTemp.createTempSync('flowfiles_move_destination_');

      try {
        final sourceFile = File('${sourceDirectory.path}/alpha.txt');

        sourceFile.writeAsStringSync('alpha');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final useCase = MoveFilesUseCase(repository);

        await useCase(
          sourcePaths: <String>[sourceFile.path],
          destinationPath: destinationDirectory.path,
        );

        final movedFile = File('${destinationDirectory.path}/alpha.txt');

        expect(await sourceFile.exists(), isFalse);
        expect(await movedFile.exists(), isTrue);
        expect(await movedFile.readAsString(), 'alpha');
      } finally {
        if (sourceDirectory.existsSync()) {
          sourceDirectory.deleteSync(recursive: true);
        }

        if (destinationDirectory.existsSync()) {
          destinationDirectory.deleteSync(recursive: true);
        }
      }
    },
  );

  test(
    'MoveFilesUseCase moves a folder and its contents',
    () async {
      final sourceDirectory = Directory.systemTemp.createTempSync(
        'flowfiles_move_folder_source_',
      );
      final destinationDirectory = Directory.systemTemp.createTempSync(
        'flowfiles_move_folder_destination_',
      );

      try {
        final sourceFolder = Directory(
          '${sourceDirectory.path}/Documents',
        );
        await sourceFolder.create();

        final sourceFile = File(
          '${sourceFolder.path}/alpha.txt',
        );
        await sourceFile.writeAsString('alpha');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final useCase = MoveFilesUseCase(repository);

        await useCase(
          sourcePaths: <String>[sourceFolder.path],
          destinationPath: destinationDirectory.path,
        );

        final movedFolder = Directory(
          '${destinationDirectory.path}/Documents',
        );
        final movedFile = File(
          '${movedFolder.path}/alpha.txt',
        );

        expect(await sourceFolder.exists(), isFalse);
        expect(await sourceFile.exists(), isFalse);
        expect(await movedFolder.exists(), isTrue);
        expect(await movedFile.exists(), isTrue);
        expect(await movedFile.readAsString(), 'alpha');
      } finally {
        if (sourceDirectory.existsSync()) {
          sourceDirectory.deleteSync(recursive: true);
        }

        if (destinationDirectory.existsSync()) {
          destinationDirectory.deleteSync(recursive: true);
        }
      }
    },
  );
}

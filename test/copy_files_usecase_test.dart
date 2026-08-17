import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/features/explorer/data/datasources/local_file_system_data_source.dart';
import 'package:fast_file_organizer/features/explorer/data/repositories/explorer_repository_impl.dart';
import 'package:fast_file_organizer/features/explorer/domain/usecases/copy_files_usecase.dart';

void main() {
  test(
    'CopyFilesUseCase copies a file to the destination directory',
    () async {
      final sourceDirectory =
          Directory.systemTemp.createTempSync('flowfiles_copy_source_');
      final destinationDirectory =
          Directory.systemTemp.createTempSync('flowfiles_copy_destination_');

      try {
        final sourceFile = File('${sourceDirectory.path}/alpha.txt');

        sourceFile.writeAsStringSync('alpha');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final useCase = CopyFilesUseCase(repository);

        await useCase(
          sourcePaths: <String>[sourceFile.path],
          destinationPath: destinationDirectory.path,
        );

        final copiedFile = File('${destinationDirectory.path}/alpha.txt');

        expect(await sourceFile.exists(), isTrue);
        expect(await copiedFile.exists(), isTrue);
        expect(await copiedFile.readAsString(), 'alpha');
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
    'CopyFilesUseCase copies a folder and its contents',
    () async {
      final sourceDirectory = Directory.systemTemp.createTempSync(
        'flowfiles_copy_folder_source_',
      );
      final destinationDirectory = Directory.systemTemp.createTempSync(
        'flowfiles_copy_folder_destination_',
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

        final useCase = CopyFilesUseCase(repository);

        await useCase(
          sourcePaths: <String>[sourceFolder.path],
          destinationPath: destinationDirectory.path,
        );

        final copiedFolder = Directory(
          '${destinationDirectory.path}/Documents',
        );
        final copiedFile = File(
          '${copiedFolder.path}/alpha.txt',
        );

        expect(await sourceFolder.exists(), isTrue);
        expect(await sourceFile.exists(), isTrue);
        expect(await copiedFolder.exists(), isTrue);
        expect(await copiedFile.exists(), isTrue);
        expect(await copiedFile.readAsString(), 'alpha');
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

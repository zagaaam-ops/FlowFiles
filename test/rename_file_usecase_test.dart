import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/features/explorer/data/datasources/local_file_system_data_source.dart';
import 'package:fast_file_organizer/features/explorer/data/repositories/explorer_repository_impl.dart';
import 'package:fast_file_organizer/features/explorer/domain/usecases/rename_file_usecase.dart';

void main() {
  late Directory tempDirectory;
  late RenameFileUseCase renameFileUseCase;

  setUp(() {
    tempDirectory = Directory.systemTemp.createTempSync(
      'flowfiles_rename_test_',
    );

    final dataSource = LocalFileSystemDataSource();
    final repository = ExplorerRepositoryImpl(dataSource);
    renameFileUseCase = RenameFileUseCase(repository);
  });

  tearDown(() {
    if (tempDirectory.existsSync()) {
      tempDirectory.deleteSync(recursive: true);
    }
  });

  test('renames a file successfully', () async {
    final source = File(
      '${tempDirectory.path}${Platform.pathSeparator}old_name.txt',
    );

    await source.writeAsString('FlowFiles test');

    await renameFileUseCase(
      sourcePath: source.path,
      newName: 'new_name.txt',
    );

    final renamed = File(
      '${tempDirectory.path}${Platform.pathSeparator}new_name.txt',
    );

    expect(await renamed.exists(), isTrue);
    expect(await source.exists(), isFalse);
    expect(await renamed.readAsString(), 'FlowFiles test');
  });

  test('renames a directory successfully', () async {
    final source = Directory(
      '${tempDirectory.path}${Platform.pathSeparator}old_folder',
    );

    await source.create();

    final child = File(
      '${source.path}${Platform.pathSeparator}test.txt',
    );

    await child.writeAsString('Folder content');

    await renameFileUseCase(
      sourcePath: source.path,
      newName: 'new_folder',
    );

    final renamed = Directory(
      '${tempDirectory.path}${Platform.pathSeparator}new_folder',
    );

    expect(await renamed.exists(), isTrue);
    expect(await source.exists(), isFalse);

    final renamedChild = File(
      '${renamed.path}${Platform.pathSeparator}test.txt',
    );

    expect(await renamedChild.exists(), isTrue);
    expect(await renamedChild.readAsString(), 'Folder content');
  });
}

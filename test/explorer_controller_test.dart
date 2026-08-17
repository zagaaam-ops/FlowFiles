import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/core/enums/sort_option.dart';
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

  test(
    'ExplorerController sorts files by name descending',
    () async {
      final tempDirectory =
          Directory.systemTemp.createTempSync('flowfiles_sort_test_');

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

        controller.setSortOption(
          SortOption.nameDescending,
        );

        expect(
          controller.state.directory!.items.map((item) => item.name),
          <String>[
            'beta.txt',
            'alpha.txt',
          ],
        );
      } finally {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      }
    },
  );

  test(
    'ExplorerController filters files by search query',
    () async {
      final tempDirectory =
          Directory.systemTemp.createTempSync('flowfiles_search_test_');

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

        controller.setSearchQuery('alpha');

        expect(controller.state.directory, isNotNull);
        expect(controller.state.directory!.items.length, 1);
        expect(
          controller.state.directory!.items.first.name,
          'alpha.txt',
        );
      } finally {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      }
    },
  );

  test(
    'ExplorerController sorts files by name ascending',
    () async {
      final tempDirectory =
          Directory.systemTemp.createTempSync('flowfiles_sort_asc_test_');

      try {
        File('${tempDirectory.path}/beta.txt').writeAsStringSync('beta');
        File('${tempDirectory.path}/alpha.txt').writeAsStringSync('alpha');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final controller = ExplorerController(
          LoadDirectoryUseCase(repository),
        );

        await controller.openDirectory(tempDirectory.path);

        controller.setSortOption(
          SortOption.nameAscending,
        );

        expect(
          controller.state.directory!.items.map((item) => item.name),
          <String>[
            'alpha.txt',
            'beta.txt',
          ],
        );
      } finally {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      }
    },
  );

  test(
    'ExplorerController sorts files by newest date',
    () async {
      final tempDirectory =
          Directory.systemTemp.createTempSync('flowfiles_date_sort_test_');

      try {
        final older = File('${tempDirectory.path}/older.txt');
        final newer = File('${tempDirectory.path}/newer.txt');

        older.writeAsStringSync('older');
        await Future<void>.delayed(const Duration(milliseconds: 50));
        newer.writeAsStringSync('newer');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final controller = ExplorerController(
          LoadDirectoryUseCase(repository),
        );

        await controller.openDirectory(tempDirectory.path);

        controller.setSortOption(
          SortOption.dateNewest,
        );

        expect(
          controller.state.directory!.items.map((item) => item.name),
          <String>[
            'newer.txt',
            'older.txt',
          ],
        );
      } finally {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      }
    },
  );

  test(
    'ExplorerController sorts files by oldest date',
    () async {
      final tempDirectory =
          Directory.systemTemp.createTempSync('flowfiles_date_oldest_test_');

      try {
        final older = File('${tempDirectory.path}/older.txt');
        final newer = File('${tempDirectory.path}/newer.txt');

        older.writeAsStringSync('older');
        await Future<void>.delayed(const Duration(milliseconds: 50));
        newer.writeAsStringSync('newer');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final controller = ExplorerController(
          LoadDirectoryUseCase(repository),
        );

        await controller.openDirectory(tempDirectory.path);

        controller.setSortOption(
          SortOption.dateOldest,
        );

        expect(
          controller.state.directory!.items.map((item) => item.name),
          <String>[
            'older.txt',
            'newer.txt',
          ],
        );
      } finally {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      }
    },
  );

  test(
    'ExplorerController sorts files by largest size',
    () async {
      final tempDirectory =
          Directory.systemTemp.createTempSync('flowfiles_size_largest_test_');

      try {
        File('${tempDirectory.path}/small.txt').writeAsStringSync('small');
        File('${tempDirectory.path}/large.txt')
            .writeAsStringSync('this is a much larger file');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final controller = ExplorerController(
          LoadDirectoryUseCase(repository),
        );

        await controller.openDirectory(tempDirectory.path);

        controller.setSortOption(
          SortOption.sizeLargest,
        );

        expect(
          controller.state.directory!.items.map((item) => item.name),
          <String>[
            'large.txt',
            'small.txt',
          ],
        );
      } finally {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      }
    },
  );

  test(
    'ExplorerController sorts files by smallest size',
    () async {
      final tempDirectory =
          Directory.systemTemp.createTempSync('flowfiles_size_smallest_test_');

      try {
        File('${tempDirectory.path}/small.txt').writeAsStringSync('small');
        File('${tempDirectory.path}/large.txt')
            .writeAsStringSync('this is a much larger file');

        final repository = ExplorerRepositoryImpl(
          LocalFileSystemDataSource(),
        );

        final controller = ExplorerController(
          LoadDirectoryUseCase(repository),
        );

        await controller.openDirectory(tempDirectory.path);

        controller.setSortOption(
          SortOption.sizeSmallest,
        );

        expect(
          controller.state.directory!.items.map((item) => item.name),
          <String>[
            'small.txt',
            'large.txt',
          ],
        );
      } finally {
        if (tempDirectory.existsSync()) {
          tempDirectory.deleteSync(recursive: true);
        }
      }
    },
  );
}

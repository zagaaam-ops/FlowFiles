import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/core/enums/sort_option.dart';
import 'package:fast_file_organizer/core/utils/file_sort_utils.dart';
import 'package:fast_file_organizer/features/explorer/domain/entities/file_entity.dart';

void main() {
  group('FileSortUtils', () {
    final List<FileEntity> files = [
      FileEntity(
        path: '/Music.mp3',
        name: 'Music.mp3',
        isDirectory: false,
        size: 300,
        lastModified: DateTime(2025, 1, 3),
        extension: 'mp3',
      ),
      FileEntity(
        path: '/Photo.jpg',
        name: 'Photo.jpg',
        isDirectory: false,
        size: 100,
        lastModified: DateTime(2025, 1, 1),
        extension: 'jpg',
      ),
      FileEntity(
        path: '/Document.pdf',
        name: 'Document.pdf',
        isDirectory: false,
        size: 200,
        lastModified: DateTime(2025, 1, 2),
        extension: 'pdf',
      ),
    ];

    test('sorts by name ascending', () {
      final result = FileSortUtils.sort(
        files,
        SortOption.nameAscending,
      );

      expect(result.first.name, 'Document.pdf');
      expect(result.last.name, 'Photo.jpg');
    });

    test('sorts by name descending', () {
      final result = FileSortUtils.sort(
        files,
        SortOption.nameDescending,
      );

      expect(result.first.name, 'Photo.jpg');
      expect(result.last.name, 'Document.pdf');
    });

    test('sorts by newest date', () {
      final result = FileSortUtils.sort(
        files,
        SortOption.dateNewest,
      );

      expect(result.first.name, 'Music.mp3');
    });

    test('sorts by oldest date', () {
      final result = FileSortUtils.sort(
        files,
        SortOption.dateOldest,
      );

      expect(result.first.name, 'Photo.jpg');
    });

    test('sorts by largest size', () {
      final result = FileSortUtils.sort(
        files,
        SortOption.sizeLargest,
      );

      expect(result.first.size, 300);
    });

    test('sorts by smallest size', () {
      final result = FileSortUtils.sort(
        files,
        SortOption.sizeSmallest,
      );

      expect(result.first.size, 100);
    });

    test('sorts by file extension', () {
      final result = FileSortUtils.sort(
        files,
        SortOption.type,
      );

      expect(result[0].extension, 'jpg');
      expect(result[1].extension, 'mp3');
      expect(result[2].extension, 'pdf');
    });
  });
}

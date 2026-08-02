import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/core/utils/file_search_utils.dart';
import 'package:fast_file_organizer/features/explorer/domain/entities/file_entity.dart';

void main() {
  group('FileSearchUtils', () {
    final List<FileEntity> files = [
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
      FileEntity(
        path: '/Music.mp3',
        name: 'Music.mp3',
        isDirectory: false,
        size: 300,
        lastModified: DateTime(2025, 1, 3),
        extension: 'mp3',
      ),
    ];

    test('returns all files when query is empty', () {
      final result = FileSearchUtils.filter(files, '');

      expect(result.length, files.length);
    });

    test('returns matching file', () {
      final result = FileSearchUtils.filter(files, 'photo');

      expect(result.length, 1);
      expect(result.first.name, 'Photo.jpg');
    });

    test('search is case insensitive', () {
      final result = FileSearchUtils.filter(files, 'DOCUMENT');

      expect(result.length, 1);
      expect(result.first.name, 'Document.pdf');
    });

    test('returns empty list when nothing matches', () {
      final result = FileSearchUtils.filter(files, 'video');

      expect(result, isEmpty);
    });
  });
}

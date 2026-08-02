import 'package:flutter_test/flutter_test.dart';
import 'package:fast_file_organizer/core/utils/file_validation_utils.dart';

void main() {
  group('FileValidationUtils', () {
    test('returns true when duplicate name exists', () {
      final names = [
        'Photo.jpg',
        'Video.mp4',
        'Music.mp3',
      ];

      expect(
        FileValidationUtils.nameExists(
          names,
          'Photo.jpg',
        ),
        isTrue,
      );
    });

    test('ignores case when checking duplicates', () {
      final names = [
        'Photo.jpg',
      ];

      expect(
        FileValidationUtils.nameExists(
          names,
          'photo.JPG',
        ),
        isTrue,
      );
    });

    test('ignores leading and trailing spaces', () {
      final names = [
        'Document.pdf',
      ];

      expect(
        FileValidationUtils.nameExists(
          names,
          '  Document.pdf  ',
        ),
        isTrue,
      );
    });

    test('returns false when name does not exist', () {
      final names = [
        'Photo.jpg',
        'Video.mp4',
      ];

      expect(
        FileValidationUtils.nameExists(
          names,
          'Music.mp3',
        ),
        isFalse,
      );
    });
  });
}

import 'package:fast_file_organizer/features/explorer/domain/entities/file_entity.dart';

class FileEntityFixture {
  const FileEntityFixture._();

  static FileEntity photo() => FileEntity(
        path: '/Photo.jpg',
        name: 'Photo.jpg',
        isDirectory: false,
        size: 100,
        lastModified: DateTime(2025, 1, 1),
        extension: 'jpg',
      );

  static FileEntity document() => FileEntity(
        path: '/Document.pdf',
        name: 'Document.pdf',
        isDirectory: false,
        size: 200,
        lastModified: DateTime(2025, 1, 2),
        extension: 'pdf',
      );

  static FileEntity music() => FileEntity(
        path: '/Music.mp3',
        name: 'Music.mp3',
        isDirectory: false,
        size: 300,
        lastModified: DateTime(2025, 1, 3),
        extension: 'mp3',
      );

  static FileEntity folder() => FileEntity(
        path: '/Documents',
        name: 'Documents',
        isDirectory: true,
        size: 0,
        lastModified: DateTime(2025, 1, 1),
        extension: '',
      );
}

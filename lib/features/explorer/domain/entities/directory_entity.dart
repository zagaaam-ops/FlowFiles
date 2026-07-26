import 'file_entity.dart';

/// Represents the contents of a directory that has been loaded
/// from the file system.
class DirectoryEntity {
  const DirectoryEntity({
    required this.path,
    required this.name,
    required this.parentPath,
    this.items = const [],
  });

  final String path;
  final String name;
  final String parentPath;
  final List<FileEntity> items;

  bool get isEmpty => items.isEmpty;

  DirectoryEntity copyWith({
    String? path,
    String? name,
    String? parentPath,
    List<FileEntity>? items,
  }) {
    return DirectoryEntity(
      path: path ?? this.path,
      name: name ?? this.name,
      parentPath: parentPath ?? this.parentPath,
      items: items ?? this.items,
    );
  }
}

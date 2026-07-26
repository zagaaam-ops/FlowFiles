/// Represents a single file or directory entry inside the Explorer.
///
/// This is a platform-independent domain entity — it should never
/// import dart:io directly. Conversion from raw filesystem objects
/// happens in the data layer (see LocalFileSystemDataSource /
/// ExplorerRepositoryImpl).
class FileEntity {
  const FileEntity({
    required this.path,
    required this.name,
    required this.isDirectory,
    required this.size,
    required this.lastModified,
    required this.extension,
  });

  final String path;
  final String name;
  final bool isDirectory;
  final int size;
  final DateTime lastModified;
  final String extension;

  FileEntity copyWith({
    String? path,
    String? name,
    bool? isDirectory,
    int? size,
    DateTime? lastModified,
    String? extension,
  }) {
    return FileEntity(
      path: path ?? this.path,
      name: name ?? this.name,
      isDirectory: isDirectory ?? this.isDirectory,
      size: size ?? this.size,
      lastModified: lastModified ?? this.lastModified,
      extension: extension ?? this.extension,
    );
  }
}

import 'dart:io';

/// Concrete, platform-specific access to the local file system
/// (Windows, Linux, macOS) using dart:io.
class LocalFileSystemDataSource {
  Future<bool> directoryExists(String path) {
    return Directory(path).exists();
  }

  Future<List<FileSystemEntity>> listDirectory(String path) async {
    final dir = Directory(path);

    if (!await dir.exists()) {
      throw FileSystemException('Directory not found', path);
    }

    return dir.list(followLinks: false).toList();
  }
}

import '../../features/explorer/domain/entities/file_entity.dart';

class FileSearchUtils {
  FileSearchUtils._();

  static List<FileEntity> filter(
    List<FileEntity> files,
    String query,
  ) {
    if (query.trim().isEmpty) {
      return files;
    }

    final search = query.toLowerCase();

    return files.where((file) {
      return file.name.toLowerCase().contains(search);
    }).toList();
  }
}

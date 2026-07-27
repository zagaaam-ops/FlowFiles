import '../../features/explorer/domain/entities/file_entity.dart';
import '../enums/sort_option.dart';

class FileSortUtils {
  FileSortUtils._();

  static List<FileEntity> sort(
    List<FileEntity> files,
    SortOption option,
  ) {
    final sorted = List<FileEntity>.from(files);

    switch (option) {
      case SortOption.nameAscending:
        sorted.sort(
          (a, b) => a.name.toLowerCase().compareTo(
                b.name.toLowerCase(),
              ),
        );
        break;

      case SortOption.nameDescending:
        sorted.sort(
          (a, b) => b.name.toLowerCase().compareTo(
                a.name.toLowerCase(),
              ),
        );
        break;

      case SortOption.dateNewest:
        sorted.sort(
          (a, b) => b.lastModified.compareTo(
                a.lastModified,
              ),
        );
        break;

      case SortOption.dateOldest:
        sorted.sort(
          (a, b) => a.lastModified.compareTo(
                b.lastModified,
              ),
        );
        break;

      case SortOption.sizeLargest:
        sorted.sort(
          (a, b) => b.size.compareTo(
                a.size,
              ),
        );
        break;

      case SortOption.sizeSmallest:
        sorted.sort(
          (a, b) => a.size.compareTo(
                b.size,
              ),
        );
        break;

      case SortOption.type:
        sorted.sort(
          (a, b) => a.extension.toLowerCase().compareTo(
                b.extension.toLowerCase(),
              ),
        );
        break;
    }

    return sorted;
  }
}

class FileFormatUtils {
  FileFormatUtils._();

  static String formatBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }

    const units = ['KB', 'MB', 'GB', 'TB'];

    double size = bytes.toDouble();
    int unit = -1;

    while (size >= 1024 && unit < units.length - 1) {
      size /= 1024;
      unit++;
    }

    return '${size.toStringAsFixed(1)} ${units[unit]}';
  }

  static String fileType(
    bool isDirectory,
    String extension,
  ) {
    if (isDirectory) {
      return 'Folder';
    }

    if (extension.isEmpty) {
      return 'File';
    }

    return '${extension.toUpperCase()} File';
  }

  static String formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final month = months[date.month - 1];

    final hh = date.hour.toString().padLeft(2, '0');
    final mm = date.minute.toString().padLeft(2, '0');

    return '${date.day} $month ${date.year}   $hh:$mm';
  }
}

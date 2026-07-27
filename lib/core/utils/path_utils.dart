import 'dart:io';

/// Utility methods for working with filesystem paths.
class PathUtils {
  PathUtils._();

  /// Returns the current user's home directory.
  static String getHomeDirectory() {
    if (Platform.isWindows) {
      return Platform.environment['USERPROFILE'] ?? 'C:\\';
    }

    return Platform.environment['HOME'] ?? '/';
  }
}

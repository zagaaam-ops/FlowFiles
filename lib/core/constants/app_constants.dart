/// =============================================================
/// FlowFiles
///
/// Application Constants
/// =============================================================
library;

class AppConstants {
  AppConstants._();

  /// Application Version
  static const String version = '0.1.0-alpha';

  /// GitHub Repository
  static const String github =
      'https://github.com/zagaaam-ops/File-Organizer-App-multi-Plateform-';

  /// Desktop breakpoint
  static const double desktopBreakpoint = 1200;

  /// Tablet breakpoint
  static const double tabletBreakpoint = 700;

  /// Default animation duration
  static const Duration animationDuration =
      Duration(milliseconds: 200);

  /// Maximum recent folders
  static const int recentFolderLimit = 20;

  /// Maximum favorite folders
  static const int favoriteFolderLimit = 50;
}

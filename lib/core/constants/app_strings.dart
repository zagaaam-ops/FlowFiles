/// =============================================================
/// FlowFiles
/// Built for organizing, not browsing.
///
/// File:
/// app_strings.dart
///
/// Central location for all user-visible text.
/// This helps with future localization and consistency.
/// =============================================================
library;

class AppStrings {
  AppStrings._();

  // -------------------------------------------------------------------------
  // Application
  // -------------------------------------------------------------------------

  static const String appName = 'FlowFiles';

  static const String appTagline =
      'Built for organizing, not browsing.';

  static const String appVersion = '0.1.0-alpha';

  // -------------------------------------------------------------------------
  // Navigation
  // -------------------------------------------------------------------------

  static const String explorer = 'Explorer';

  static const String organizer = 'Organizer';

  static const String favorites = 'Favorites';

  static const String search = 'Search';

  static const String settings = 'Settings';

  // -------------------------------------------------------------------------
  // Organizer
  // -------------------------------------------------------------------------

  static const String organizerMode = 'Organizer Mode';

  static const String sourceFolder = 'Source Folder';

  static const String destinationFolders = 'Destination Folders';

  static const String filesSelected = 'Files Selected';

  static const String move = 'Move';

  static const String copy = 'Copy';

  static const String undo = 'Undo';

  static const String cancel = 'Cancel';

  // -------------------------------------------------------------------------
  // Messages
  // -------------------------------------------------------------------------

  static const String emptyFolder =
      'This folder does not contain any files.';

  static const String noSelection =
      'No files selected.';

  static const String loading =
      'Loading...';

  static const String ready =
      'Ready';

  static const String error =
      'Something went wrong.';
}

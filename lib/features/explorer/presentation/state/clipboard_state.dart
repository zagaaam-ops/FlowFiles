enum ClipboardOperation {
  none,
  copy,
  cut,
}

///
/// Represents the current clipboard state for Explorer.
///
/// This class does NOT perform any file operations.
/// It only stores which files are currently in the clipboard
/// and whether they are being copied or cut.
///
class ClipboardState {
  const ClipboardState({
    this.paths = const [],
    this.operation = ClipboardOperation.none,
  });

  /// Files currently stored in the clipboard.
  final List<String> paths;

  /// Current clipboard operation.
  final ClipboardOperation operation;

  bool get hasData => paths.isNotEmpty;

  bool get isCopy => operation == ClipboardOperation.copy;

  bool get isCut => operation == ClipboardOperation.cut;

  ClipboardState copyWith({
    List<String>? paths,
    ClipboardOperation? operation,
  }) {
    return ClipboardState(
      paths: paths ?? this.paths,
      operation: operation ?? this.operation,
    );
  }

  static const empty = ClipboardState();
}

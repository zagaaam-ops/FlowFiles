import 'package:flutter/foundation.dart';

enum ClipboardOperation {
  copy,
  cut,
}

@immutable
class ClipboardState {
  const ClipboardState({
    this.paths = const <String>[],
    this.operation,
  });

  final List<String> paths;
  final ClipboardOperation? operation;

  bool get hasData => paths.isNotEmpty && operation != null;

  ClipboardState copyWith({
    List<String>? paths,
    ClipboardOperation? operation,
  }) {
    return ClipboardState(
      paths: paths ?? this.paths,
      operation: operation ?? this.operation,
    );
  }
}

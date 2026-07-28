import 'package:flutter/foundation.dart';

import '../state/clipboard_state.dart';

class ClipboardController extends ChangeNotifier {
  ClipboardState _state = ClipboardState.empty;

  ClipboardState get state => _state;

  bool get hasClipboard => _state.hasData;

  void copy(Iterable<String> paths) {
    _state = ClipboardState(
      paths: List<String>.from(paths),
      operation: ClipboardOperation.copy,
    );
    notifyListeners();
  }

  void cut(Iterable<String> paths) {
    _state = ClipboardState(
      paths: List<String>.from(paths),
      operation: ClipboardOperation.cut,
    );
    notifyListeners();
  }

  void clear() {
    _state = ClipboardState.empty;
    notifyListeners();
  }
}

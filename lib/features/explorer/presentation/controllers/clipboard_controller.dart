import 'package:flutter/foundation.dart';

import '../state/clipboard_state.dart';

class ClipboardController extends ChangeNotifier {
  ClipboardState _state = const ClipboardState();

  ClipboardState get state => _state;

  bool get hasData => _state.hasData;

  void copy(List<String> paths) {
    _state = ClipboardState(
      paths: List<String>.from(paths),
      operation: ClipboardOperation.copy,
    );

    notifyListeners();
  }

  void cut(List<String> paths) {
    _state = ClipboardState(
      paths: List<String>.from(paths),
      operation: ClipboardOperation.cut,
    );

    notifyListeners();
  }

  void clear() {
    _state = const ClipboardState();

    notifyListeners();
  }
}

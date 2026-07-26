import '../../domain/entities/selection_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'selection_notifier.dart';

final selectionProvider =
    StateNotifierProvider<SelectionNotifier, SelectionState>(
  (ref) => SelectionNotifier(),
);

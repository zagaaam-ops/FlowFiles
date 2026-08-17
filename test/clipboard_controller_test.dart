import 'package:flutter_test/flutter_test.dart';

import 'package:fast_file_organizer/features/explorer/presentation/controllers/clipboard_controller.dart';
import 'package:fast_file_organizer/features/explorer/presentation/state/clipboard_state.dart';

void main() {
  test('copy stores paths with copy operation', () {
    final controller = ClipboardController();

    controller.copy([
      '/tmp/alpha.txt',
      '/tmp/beta.txt',
    ]);

    expect(controller.hasData, isTrue);
    expect(
      controller.state.paths,
      <String>[
        '/tmp/alpha.txt',
        '/tmp/beta.txt',
      ],
    );
    expect(
      controller.state.operation,
      ClipboardOperation.copy,
    );
  });

  test('cut stores paths with cut operation', () {
    final controller = ClipboardController();

    controller.cut([
      '/tmp/alpha.txt',
    ]);

    expect(controller.hasData, isTrue);
    expect(
      controller.state.paths,
      <String>[
        '/tmp/alpha.txt',
      ],
    );
    expect(
      controller.state.operation,
      ClipboardOperation.cut,
    );
  });

  test('clear removes clipboard data', () {
    final controller = ClipboardController();

    controller.copy([
      '/tmp/alpha.txt',
    ]);

    controller.clear();

    expect(controller.hasData, isFalse);
    expect(controller.state.paths, isEmpty);
    expect(controller.state.operation, isNull);
  });
}

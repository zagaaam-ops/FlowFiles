import 'package:flutter_test/flutter_test.dart';
import 'package:fast_file_organizer/main.dart';

void main() {
  testWidgets('FlowFiles app launches successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(const FlowFilesApp());

    await tester.pump();

    expect(find.byType(FlowFilesApp), findsOneWidget);
  });
}

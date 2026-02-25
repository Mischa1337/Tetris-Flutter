import 'package:flutter_test/flutter_test.dart';
import 'package:tetris_app/main.dart';

void main() {
  testWidgets('TetrisApp startet ohne Fehler', (WidgetTester tester) async {
    await tester.pumpWidget(const TetrisApp());
    await tester.pump();

    expect(find.text('SCORE'), findsOneWidget);
    expect(find.text('LEVEL'), findsOneWidget);
    expect(find.text('LINES'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:fortuneapp/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FortuneApp());
    expect(find.textContaining('오늘의 메시지'), findsOneWidget);
  });
}

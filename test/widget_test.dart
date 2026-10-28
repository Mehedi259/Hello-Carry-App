import 'package:flutter_test/flutter_test.dart';
import 'package:hello_carry/main.dart';

void main() {
  testWidgets('Hello Carry App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HelloCarryApp());
    expect(find.byType(HelloCarryApp), findsOneWidget);
  });
}

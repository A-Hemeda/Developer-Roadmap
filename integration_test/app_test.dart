import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chessclock/main.dart' as app;

void main() => run(_testMain);

run(void Function() testMain) {}

void _testMain() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

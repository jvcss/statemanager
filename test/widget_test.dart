// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:statemanager/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ContacstPage());

    // Verify that the initial screen is an empty list.
    expect(find.text('empty'), findsOneWidget);
    expect(find.text('something'), findsNothing);

    // Tap the '+' icon and open a new page.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // interact with the new page to fulfil the test contact name
    await tester.enterText(find.byType(TextField), 'something');
    await tester.tap(find.text('Create'));

    // Verify that our counter has incremented.
    expect(find.text('empty'), findsNothing);
    expect(find.text('something'), findsOneWidget);
  });
}

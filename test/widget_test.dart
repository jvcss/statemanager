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
  testWidgets('Add Contact Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that the initial screen is an empty list.
    expect(find.text('No contacts found'), findsOneWidget);
    expect(find.text('something'), findsNothing);

    // Tap the '+' icon and open a new page.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); // Aguarda a animação e a navegação completa.

    expect(find.text('Name'), findsOneWidget);
    expect(find.byTooltip('Create'), findsOneWidget);

    // interact with the new page to fulfil the test contact name
    await tester.enterText(find.byType(TextField), 'something');
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.plus_one));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(find.text('No contacts found'), findsNothing);
    expect(find.text('something'), findsOneWidget);
  });
}

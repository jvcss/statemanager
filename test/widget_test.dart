// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:statemanager/main.dart';
import 'package:statemanager/random_names_cubit.dart';

void main() {
  testWidgets('Random name Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at empty message.
    expect(find.text('Press the button to generate a name'), findsOneWidget);
    expect(find.byElementPredicate(
      (Element element) => element.widget is Text && names.contains((element.widget as Text).data),
    ), findsNothing);
  
    // check if the constant information is present
    expect(find.text('Random Name'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pumpAndSettle();

    expect(find.text('Press the button to generate a name'), findsNothing);// new name is generated
    expect(find.byElementPredicate(
      (Element element) => element.widget is Text && names.contains((element.widget as Text).data),
    ), findsOneWidget); // should find the new name in the list
  });
}

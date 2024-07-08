
import 'package:flutter_test/flutter_test.dart';
import 'package:statemanager/main.dart';
void main() {
  testWidgets( 'With sliver', (WidgetTester tester) async{
    await tester.pumpWidget(const App());
    expect(find.text('Variable view managed:'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });
}

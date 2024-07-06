
import 'package:flutter/material.dart';
import 'package:statemanager/helper/strings.dart' show login;
import 'package:flutter_test/flutter_test.dart';
import 'package:statemanager/main.dart';
import 'package:statemanager/widget/email_textfield.dart';
import 'package:statemanager/widget/extensions/login_button.dart';
import 'package:statemanager/widget/password_textfield.dart';

void main() {
  testWidgets( 'With sliver', (WidgetTester tester) async{
    await tester.pumpWidget(const App(showSliver: true,));
    expect(find.byType(EmailTextField), findsOneWidget);
    expect(find.byType(PasswordTextField), findsOneWidget);
    expect(find.byType(LoginButton), findsNothing); // * bug with sliver?

  });
  testWidgets('Without Sliver', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const App(showSliver: false,));

    // Verify that the app displays the initial UI elements.
    //expect(find.text('Welcome to Flutter'), findsOneWidget);
    expect(find.byType(EmailTextField), findsOneWidget);
    expect(find.byType(PasswordTextField), findsOneWidget);
    expect(find.byType(LoginButton), findsOneWidget);

    //expect(find.byType(LoginButton), findsNothing);

    // // Enter text into the email and password fields.
    // await tester.enterText(find.byType(EmailTextField), 'admin');
    // await tester.enterText(find.byType(PasswordTextField), 'admin');

    // // Tap the login button.
    // await tester.tap(find.text('Login'));

    // // Rebuild the widget after the state has changed.
    // await tester.pump();

    // // Verify that the email and password were logged (This part can be tricky
    // // as devtools.log doesn't actually affect the UI. We may need to mock the logging or check the controllers).
    // final emailTextField = tester.widget<EmailTextField>(find.byType(EmailTextField));
    // final passwordTextField = tester.widget<PasswordTextField>(find.byType(PasswordTextField));

    // expect(emailTextField.controller.text, 'admin');
    // expect(passwordTextField.controller.text, 'admin');
  });
}

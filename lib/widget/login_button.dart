import 'package:flutter/material.dart';
import 'package:statemanager/dialogs/generic_dialogs.dart';
import 'package:statemanager/helper/strings.dart' show emailOrPasswordEmptyDialogMessage,
 emailOrPasswordEmptyDialogTitle,
  login,
   ok;

typedef OnLoginTapped = bool Function(
  String email,
  String password,
);

class LoginButton extends StatelessWidget {
  final OnLoginTapped onLoginTapped;
  final TextEditingController emailField;
  final TextEditingController passwordField;

  const LoginButton({
    super.key,
    required this.onLoginTapped,
    required this.emailField,
    required this.passwordField,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final email = emailField.text;
        final password = passwordField.text;
        if (email.isEmpty || password.isEmpty) {
          showGenericDialog<bool>(
            context: context,
            title: emailOrPasswordEmptyDialogTitle,
            content: emailOrPasswordEmptyDialogMessage,
            options: () => {
              ok: true,
            },
          );
        } else {
          onLoginTapped(email, password);
        }
      },
      child: const Text(login),
    );
  }
}

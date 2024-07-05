import 'package:flutter/material.dart';
import 'package:statemanager/helper/strings.dart' show enterYourPasswordDialogTitle, passwordText;

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordTextField({
    super.key,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: passwordText,
        hintText: enterYourPasswordDialogTitle,
      ),
    );
  }
}

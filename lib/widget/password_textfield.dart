import 'package:flutter/material.dart';
import 'package:statemanager/helper/strings.dart' show enterYourPasswordDialogTitle, passwordText;

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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

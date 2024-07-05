import 'package:flutter/material.dart';
import 'package:statemanager/helper/strings.dart' show emailText, enterYourEmailDialogTitle;

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;

  const EmailTextField({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: emailText,
        hintText: enterYourEmailDialogTitle,
      ),
    );
  }
}

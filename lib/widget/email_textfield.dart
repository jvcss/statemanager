import 'package:flutter/material.dart';
import 'package:statemanager/helper/strings.dart' show emailText, enterYourEmailDialogTitle;

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: emailText,
        hintText: enterYourEmailDialogTitle,
      ),
    );
  }
}

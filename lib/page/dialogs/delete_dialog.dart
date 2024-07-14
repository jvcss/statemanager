import 'package:flutter/material.dart' show BuildContext;
import 'package:statemanager/page/dialogs/generic_dialogs.dart';

Future<bool> showDialogDeleteAccout(BuildContext context) {
  return showDialogGeneric<bool>(
    context: context,
    title: 'Delete Account',
    content: 'Are you sure you want to delete your account?',
    options: () => {
      'No': false,
      'Yes': true,
    },
  ).then((value) => value ?? false);
}

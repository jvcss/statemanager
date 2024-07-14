
import 'package:flutter/material.dart' show BuildContext;
import 'package:statemanager/page/dialogs/generic_dialogs.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showDialogGeneric<bool>(
    context: context,
    title: 'Logout',
    content: 'Are you sure you want to logout?',
    options: () => {
      'No': false,
      'Yes': true,
    },
  ).then((value) => value ?? false);
}
import 'package:flutter/material.dart' show BuildContext;
import 'package:statemanager/utils/auth/auth_error.dart';
import 'package:statemanager/page/dialogs/generic_dialogs.dart';

Future<void> showDialogAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showDialogGeneric<void>(
    context: context,
    title: 'Authentication Error',
    content: 'An error occurred while trying to authenticate you. Please try again.',
    options: () => {
      'Ok': false,
    },
  );
}

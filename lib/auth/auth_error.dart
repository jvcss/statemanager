import 'package:flutter/foundation.dart' show immutable;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

const Map<String, AuthError> authErrorMapping = {
  'no current-user': AuthErrorNoCurrentUser(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'operation-not_allowed': AuthErrorOperationNotAllowed(),
  'user-not-found': AuthErrorUserNotFound(),
  'invalid-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;

  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(FirebaseAuthException exception) => authErrorMapping[exception.code.toLowerCase().trim()] ?? const AuthErrorUnknown();
}

@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown() : super(
    dialogTitle: 'Unknown Error',
    dialogText: 'An unknown error occurred.',
  );
}

@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser() : super(
    dialogTitle: 'No Current User',
    dialogText: 'No user is currently signed in.',
  );
}

@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin() : super(
    dialogTitle: 'Requires Recent Login',
    dialogText: 'This operation is sensitive and requires recent authentication. Log in again before retrying this request.',
  );
}

@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed() : super(
    dialogTitle: 'Operation Not Allowed',
    dialogText: 'This operation is not allowed.',
  );
}

@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound() : super(
    dialogTitle: 'User Not Found',
    dialogText: 'There is no user record corresponding to this identifier. The user may have been deleted.',
  );
}

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword() : super(
    dialogTitle: 'Weak Password',
    dialogText: 'The password must be 6 characters long or more.',
  );
}

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail() : super(
    dialogTitle: 'Invalid Email',
    dialogText: 'The email address is badly formatted.',
  );
}


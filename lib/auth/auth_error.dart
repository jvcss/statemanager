import 'package:flutter/foundation.dart' show immutable;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

const Map<String, AuthError> authErrorMapping = {
  'no-current-user': AuthErrorNoCurrentUser(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'app-deleted': AuthErrorAppDeleted(),
  'app-not-authorized': AuthErrorAppNotAuthorized(),
  'argument-error': AuthErrorArgumentError(),
  'invalid-api-key': AuthErrorInvalidApiKey(),
  'invalid-user-token': AuthErrorInvalidUserToken(),
  'invalid-tenant-id': AuthErrorInvalidTenantId(),
  'network-request-failed': AuthErrorNetworkRequestFailed(),
  'too-many-requests': AuthErrorTooManyRequests(),
  'unauthorized-domain': AuthErrorUnauthorizedDomain(),
  'user-disabled': AuthErrorUserDisabled(),
  'user-token-expired': AuthErrorUserTokenExpired(),
  'web-storage-unsupported': AuthErrorWebStorageUnsupported(),
};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;

  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(FirebaseAuthException exception) => 
    authErrorMapping[exception.code.toLowerCase().trim()] ?? const AuthErrorUnknown();
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

@immutable
class AuthErrorAppDeleted extends AuthError {
  const AuthErrorAppDeleted() : super(
    dialogTitle: 'App Deleted',
    dialogText: 'The instance of FirebaseApp has been deleted.',
  );
}

@immutable
class AuthErrorAppNotAuthorized extends AuthError {
  const AuthErrorAppNotAuthorized() : super(
    dialogTitle: 'App Not Authorized',
    dialogText: 'The app identified by the domain where it\'s hosted is not authorized to use Firebase Authentication with the provided API key. Review your key configuration in the Google API console.',
  );
}

@immutable
class AuthErrorArgumentError extends AuthError {
  const AuthErrorArgumentError() : super(
    dialogTitle: 'Argument Error',
    dialogText: 'A method was called with incorrect arguments.',
  );
}

@immutable
class AuthErrorInvalidApiKey extends AuthError {
  const AuthErrorInvalidApiKey() : super(
    dialogTitle: 'Invalid API Key',
    dialogText: 'The provided API key is invalid. Please check that you have copied it correctly from the Firebase Console.',
  );
}

@immutable
class AuthErrorInvalidUserToken extends AuthError {
  const AuthErrorInvalidUserToken() : super(
    dialogTitle: 'Invalid User Token',
    dialogText: 'The user\'s credential is no longer valid. The user must sign in again.',
  );
}

@immutable
class AuthErrorInvalidTenantId extends AuthError {
  const AuthErrorInvalidTenantId() : super(
    dialogTitle: 'Invalid Tenant ID',
    dialogText: 'The tenant ID provided is invalid.',
  );
}

@immutable
class AuthErrorNetworkRequestFailed extends AuthError {
  const AuthErrorNetworkRequestFailed() : super(
    dialogTitle: 'Network Request Failed',
    dialogText: 'A network error (such as timeout, interrupted connection, or unreachable host) has occurred.',
  );
}

@immutable
class AuthErrorTooManyRequests extends AuthError {
  const AuthErrorTooManyRequests() : super(
    dialogTitle: 'Too Many Requests',
    dialogText: 'Requests are blocked from a device due to unusual activity. Trying again after some delay would unblock.',
  );
}

@immutable
class AuthErrorUnauthorizedDomain extends AuthError {
  const AuthErrorUnauthorizedDomain() : super(
    dialogTitle: 'Unauthorized Domain',
    dialogText: 'The app domain is not authorized for OAuth operations for your Firebase project. Edit the list of authorized domains from the Firebase console.',
  );
}

@immutable
class AuthErrorUserDisabled extends AuthError {
  const AuthErrorUserDisabled() : super(
    dialogTitle: 'User Disabled',
    dialogText: 'The user account has been disabled by an administrator. Accounts can be enabled or disabled in the Firebase Console, the Auth section, and Users subsection.',
  );
}

@immutable
class AuthErrorUserTokenExpired extends AuthError {
  const AuthErrorUserTokenExpired() : super(
    dialogTitle: 'User Token Expired',
    dialogText: 'The user\'s credential has expired. This could also be thrown if a user has been deleted. Prompting the user to sign in again should resolve this for either case.',
  );
}

@immutable
class AuthErrorWebStorageUnsupported extends AuthError {
  const AuthErrorWebStorageUnsupported() : super(
    dialogTitle: 'Web Storage Unsupported',
    dialogText: 'The browser does not support web storage or if the user disables them.',
  );
}

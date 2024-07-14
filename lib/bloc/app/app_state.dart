import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:statemanager/utils/auth/auth_error.dart';

@immutable
abstract class AppState {
  final bool isLoading;
  final AuthError? authError;

  const AppState({
    required this.isLoading,
    this.authError,
  });
}

@immutable
class AppStateLoggedIn extends AppState {
  final User user;
  final Iterable<Reference> firebaseReferences;
  const AppStateLoggedIn({
    required super.isLoading,
    super.authError,
    required this.user,
    required this.firebaseReferences,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppStateLoggedIn && other.user == user && listEquals(other.firebaseReferences.toList(), firebaseReferences.toList()) && other.isLoading == isLoading && other.authError == authError;
  }

  @override
  int get hashCode => Object.hash(
        user,
        Object.hashAll(firebaseReferences),
        isLoading,
        authError,
      );

  @override
  String toString() {
    return 'AppStateLoggedIn(user: $user, firebaseReferences: $firebaseReferences, isLoading: $isLoading, authError: $authError)';
  }
}

@immutable
class AppStateLoggedOut extends AppState {
  const AppStateLoggedOut({
    required super.isLoading,
    super.authError,
  });

  @override
  String toString() {
    return 'AppStateLoggedOut(isLoading: $isLoading, authError: $authError)';
  }
}

@immutable
class AppStateIsInRegistrationView extends AppState {
  const AppStateIsInRegistrationView({
    required super.isLoading,
    super.authError,
  });

  @override
  String toString() {
    return 'AppStateIsInRegistrationView(isLoading: $isLoading, authError: $authError)';
  }
}


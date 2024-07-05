
import 'package:flutter/foundation.dart' show immutable;

@immutable 
abstract class AppEvent {
  const AppEvent();
}

@immutable class LoginEvent implements AppEvent {
  const LoginEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

@immutable class LoadNotesAction implements AppEvent {
  const LoadNotesAction();
}

@immutable class LogoutAction implements AppEvent {
  const LogoutAction();
}
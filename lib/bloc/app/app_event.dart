part of 'app_bloc.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class LoginEvent implements AppEvent {
  const LoginEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

@immutable
class LoadNotesEvent implements AppEvent {
  const LoadNotesEvent();
}

@immutable
class LogoutEvent implements AppEvent {
  const LogoutEvent();
}

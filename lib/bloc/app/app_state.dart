import 'package:flutter/foundation.dart' show immutable;

import 'package:statemanager/model/login_model.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginErrors? loginError;
  final Iterable<Note>? notes;
  final LoginModel? loginModel;

  const AppState.initialState()
      : isLoading = false,
        loginError = null,
        notes = null,
        loginModel = null;

  const AppState({
    required this.isLoading,
    required this.loginError,
    required this.notes,
    required this.loginModel,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'loginError': loginError,
        'notes': notes,
        'loginModel': loginModel,
      }.toString();
}

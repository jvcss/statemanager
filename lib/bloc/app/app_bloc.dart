import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:statemanager/api/login/login_interface.dart';
import 'package:statemanager/api/note/notes_api_interface.dart';

import 'package:statemanager/model/login_model.dart';
import 'package:statemanager/model/note_model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(
          const AppState.initialState(),
        ) {
    on<LoginEvent>(_onLogin);
    on<LoadNotesEvent>(_onNotes);
  }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AppState> emit) async {
    final loginModel = await loginApi.login(
      username: event.username,
      password: event.password,
    );
    //start loading
    emit(
      state.copyWith(
        isLoading: true,
        loginError: loginModel == null ? LoginErrors.invalidModel : null,
        loginModel: loginModel,
        // all null values stay the same
      ),
    );
  }

  FutureOr<void> _onNotes(LoadNotesEvent event, Emitter<AppState> emit) async {
    emit(
      state.copyWith(
        loginModel: state.loginModel,
        isLoading: true,
        notes: [],
      ),
    );

    final loginModel = state.loginModel;
    if (loginModel != const LoginModel.fooBar()) {
      emit(
        state.copyWith(
          isLoading: false,
          loginError: LoginErrors.invalidModel,
          loginModel: loginModel,
          notes: null,
        ),
      );
      return null;
    }
    final notes = await notesApi.fetchNotes(loginModel: loginModel!);
    emit(
      state.copyWith(
        isLoading: false,
        loginError: null,
        loginModel: loginModel,
        notes: notes,
      ),
    );
  }
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:statemanager/api/login/login_interface.dart';
import 'package:statemanager/api/note/notes_api_interface.dart';
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/model/login_model.dart';
import 'package:statemanager/model/note_model.dart';

class MockNotesApi implements NotesApiProtocol {
  final LoginModel acceptableLoginModel;
  final Iterable<Note>? notesToReturnForAcceptableLoginModel;

  MockNotesApi({required this.acceptableLoginModel, required this.notesToReturnForAcceptableLoginModel});

  const MockNotesApi.mockNoteState()
      : acceptableLoginModel = const LoginModel.adminAccount(),
        notesToReturnForAcceptableLoginModel = null;

  @override
  Future<Iterable<Note>?> fetchNotes({required LoginModel loginModel}) async {
    if (loginModel != acceptableLoginModel) {
      return Future.value(null);
    }
    return notesToReturnForAcceptableLoginModel;
  }
}

class MockLoginApi implements LoginApiProtocol {
  final LoginModel acceptableLoginModel;
  final String acceptableEmail;
  final String acceptablePassword;
  final bool loginSuccess;

  MockLoginApi({
    required this.acceptableEmail,
    required this.acceptablePassword,
    required this.acceptableLoginModel,
    required this.loginSuccess,
  });

  const MockLoginApi.mockLoginState()
      : acceptableLoginModel = const LoginModel.adminAccount(),
        loginSuccess = true,
        acceptableEmail = 'admin',
        acceptablePassword = 'admin';

  @override
  Future<LoginModel?> login({required String username, required String password}) async {
    if (username != acceptableEmail || password != acceptablePassword) {
      return null;
    }
    return const LoginModel.adminAccount();
  }
}

void main() {
  blocTest<AppBloc, AppState>(
    'can we open the app and see the login screen',
    build: () => AppBloc(
      acceptableLoginModel: const LoginModel.adminAccount(),
      loginApi: const MockLoginApi.mockLoginState(),
      notesApi: const MockNotesApi.mockNoteState(),
    ),
    verify: (bloc) {
      // The initial state should be the AppState.initialState()
      expect(
        bloc.state,
        const AppState.initialState(),
      );
    },
  );

  blocTest<AppBloc, AppState>(
    'can we log in with the correct credentials',
    build: () => AppBloc(
      acceptableLoginModel: const LoginModel.adminAccount(),
      loginApi: MockLoginApi(acceptableEmail: 'admin', acceptablePassword: 'admin', acceptableLoginModel: const LoginModel.adminAccount(), loginSuccess: true),
      notesApi: const MockNotesApi.mockNoteState(),
    ),
    act: (bloc) => bloc.add(const LoginEvent(username: 'admin', password: 'admin')),
    expect: () => [
      const AppState(isLoading: true, loginError: null, notes: null, loginModel: null),
      const AppState(isLoading: false, loginError: null, notes: null, loginModel: LoginModel.adminAccount()),
    ],
  );

  blocTest<AppBloc, AppState>(
    'can we not log in with the correct credentials',
    build: () => AppBloc(
      acceptableLoginModel: const LoginModel.adminAccount(),
      loginApi: MockLoginApi(acceptableEmail: 'admin', acceptablePassword: 'admin1', acceptableLoginModel: const LoginModel.adminAccount(), loginSuccess: true),
      notesApi: const MockNotesApi.mockNoteState(),
    ),
    act: (bloc) => bloc.add(const LoginEvent(username: 'admin', password: 'admin')),
    expect: () => [
      const AppState(isLoading: true, loginError: null, notes: null, loginModel: null),
      const AppState(isLoading: false, loginError: LoginErrors.invalidModel, notes: null, loginModel: null),
    ],
  );

  blocTest<AppBloc, AppState>(
    'loading notes with the correct credentials',
    build: () => AppBloc(
      acceptableLoginModel: const LoginModel.adminAccount(),
      loginApi: MockLoginApi(acceptableEmail: 'admin', acceptablePassword: 'admin', acceptableLoginModel: const LoginModel.adminAccount(), loginSuccess: true),
      notesApi: MockNotesApi(acceptableLoginModel: const LoginModel.adminAccount(), notesToReturnForAcceptableLoginModel: mockNotes),
    ),
    act: (bloc) {
      bloc.add(const LoginEvent(username: 'admin', password: 'admin'));
      bloc.add(const LoadNotesEvent());
    },
    expect: () => [
      const AppState(isLoading: true, loginError: null, notes: null, loginModel: null),
      const AppState(isLoading: false, loginError: null, notes: null, loginModel: LoginModel.adminAccount()),
      const AppState(isLoading: true, loginError: null, notes: null, loginModel: LoginModel.adminAccount()),
      AppState(isLoading: false, loginError: null, notes: mockNotes, loginModel: const LoginModel.adminAccount()),
    ],
  );
}

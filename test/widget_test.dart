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
import 'package:statemanager/main.dart';
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
    'description',
    build: () => AppBloc(
      loginApi: const MockLoginApi.mockLoginState(),
      notesApi: const MockNotesApi.mockNoteState(),
    ),
    verify: (bloc) => expect(
      bloc.state,
      const AppState.initialState(),
    ),
  );
}

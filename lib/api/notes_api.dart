import 'package:flutter/foundation.dart' show immutable;
import 'package:statemanager/model/login_model.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Note>?> fetchNotes({
    required LoginModel loginModel,
  });
}

@immutable
class NotesApi implements NotesApiProtocol {
  const NotesApi._sharedInstance(); // ! singleton
  static const NotesApi _shared = NotesApi._sharedInstance();
  factory NotesApi() => _shared;

  @override
  Future<Iterable<Note>?> fetchNotes({
    required LoginModel loginModel,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => loginModel == const LoginModel.fooBar() ? mockNotes : null,
      );
}

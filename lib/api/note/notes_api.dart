part of 'notes_api_interface.dart';

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
        () => loginModel == const LoginModel.adminAccount() ? mockNotes : null,
      );
}

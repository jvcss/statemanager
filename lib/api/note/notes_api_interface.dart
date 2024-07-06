import 'package:flutter/foundation.dart' show immutable;
import 'package:statemanager/model/login_model.dart';
import 'package:statemanager/model/note_model.dart';

part 'notes_api.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Note>?> fetchNotes({
    required LoginModel loginModel,
  });
}

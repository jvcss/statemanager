import 'package:flutter/foundation.dart' show immutable;

@immutable
class LoginModel {
  final String token;

  const LoginModel({
    required this.token,
  });

  const LoginModel.fooBar() : token = 'foobar';

  @override
  bool operator ==(covariant LoginModel other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHandle(token: $token)';
}

enum LoginErrors {
  invalidHandle,
}

@immutable
class Note {
  final String title;

  const Note({required this.title});

  @override
  String toString() => 'Note{title: $title}';
}

final mockNotes = Iterable.generate(
  3,
  (i) => Note(
    title: 'Note ${i + 1}',
  ),
);

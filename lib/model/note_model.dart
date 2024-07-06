import 'package:flutter/foundation.dart' show immutable;

@immutable
class Note {
  final String title;

  const Note({required this.title});

  @override
  String toString() => 'Note(title: $title)';
}

final mockNotes = Iterable.generate(
  9,
  (i) => Note(
    title: 'Note ${i + 1}',
  ),
);

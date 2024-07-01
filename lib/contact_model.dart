import 'package:uuid/uuid.dart';

class Contact {
  final String uuid;
  final String name;

  Contact({
    required this.name,
  })  : assert(name.isNotEmpty),
        uuid = const Uuid().v4();
}
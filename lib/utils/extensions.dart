
import 'package:flutter/foundation.dart' show debugPrint;

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) => length == other.length && {...this}.intersection({...other}).length == length;
}

extension Log on Object {
  void log() => debugPrint(toString());
}

const String person2 = 'https://jsonplaceholder.typicode.com/users/1';
const String person1 = 'https://jsonplaceholder.typicode.com/users/1';

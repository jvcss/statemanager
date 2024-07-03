
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

const String person1 = 'http://10.0.2.2:5500/api/persons1.json';
const String person2 = 'http://10.0.2.2:5500/api/persons2.json';

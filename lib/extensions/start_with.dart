import 'package:async/async.dart' show StreamGroup;
import 'dart:math' as math;

extension StartWith<T> on Stream<T> {
  /*
    this:          | ----- X ----- X
    Stream.value:  | X | 
    merge:        | X ----- X ----- X
   */
  Stream<T> startWith(T value) => StreamGroup.merge(
        [
          this,
          Stream<T>.value(value),
        ],
      );
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() {
    final randomIndex = math.Random().nextInt(length);
    return elementAt(randomIndex);
  }
}

extension Comparison<E> on List<E> {
  bool isEqualTo(List<E> other) {
    if (identical(this, other)) return true;
    if (length != other.length) return false;
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}


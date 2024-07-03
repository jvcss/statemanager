import 'dart:math';

extension RandomElement<T> on Iterable<T> {
  T random() {
    final random = Random();
    return elementAt(random.nextInt(length));
  }
}

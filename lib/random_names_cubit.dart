import 'dart:math' as math show Random;
import 'package:bloc/bloc.dart';

const names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

extension RandomElement<T> on Iterable<T> {
  T get random => elementAt(math.Random().nextInt(length));
  T getRandom() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);
  void generateRandomName() {
    var n = names.random;
    while (state == n) {
      n = names.getRandom();
    }
    if (state != n) {
      emit(n);
    }
  }
}

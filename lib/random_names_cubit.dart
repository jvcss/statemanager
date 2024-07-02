import 'dart:math' as math show Random;
import 'package:bloc/bloc.dart';

const names = ['John', 'Jane', 'Jack', 'Jill', 'Jenny', 'Jerry', 'Judy', 'Jesse'];

extension RandomElement<T> on Iterable<T> {
  T get random => elementAt(math.Random().nextInt(length));
  //T getRandom() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);
  void generateRandomName() => emit(names.random);
}

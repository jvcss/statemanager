import 'package:flutter/foundation.dart'
    show immutable;
import 'package:statemanager/service/api.dart';

// @immutable
// class Thing {
//   final String name;

//   const Thing({required this.name});
// }

abstract class Thing {
  final String name;

  /// Construtor constante com parâmetro nomeado `name`.
  const Thing({required this.name});

  /// Deve retornar um Map<String, dynamic> contendo todas as
  /// propriedades “pesquisáveis” desse objeto.
  Map<String, dynamic> toSearchableMap();

  /// Verifica se `term` está contido em qualquer valor do mapa
  /// retornado por `toSearchableMap`.
  bool matches(SearchTerm term) {
    final keyLower = term.trim().toLowerCase();
    for (final value
        in toSearchableMap().values) {
      if (value == null) continue;
      if (value
          .toString()
          .trim()
          .toLowerCase()
          .contains(keyLower)) {
        return true;
      }
    }
    return false;
  }
}

import 'package:flutter/foundation.dart';
import 'package:statemanager/models/person.dart';
import 'package:statemanager/utils/extensions.dart';

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;
  const FetchResult({
    required this.isRetrievedFromCache,
    required this.persons,
  });

  @override
  String toString() {
    return 'FetchResult ( isRetrievedFromCache: $isRetrievedFromCache, persons: $persons )';
  }

  @override
  bool operator ==(covariant FetchResult other) => isRetrievedFromCache == other.isRetrievedFromCache && persons.isEqualToIgnoringOrdering(other.persons);

  @override
  int get hashCode => Object.hash(isRetrievedFromCache, persons);
}

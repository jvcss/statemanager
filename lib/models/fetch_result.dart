import '../imports.dart';
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
    return 'FetchResult{persons: $persons, isRetrievedFromCache: $isRetrievedFromCache}';
  }
}

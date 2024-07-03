import '../imports.dart';

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, FetchResult> _cache = {};
  PersonBloc() : super(null) {
// without external link ^ but share through bloc
    on<LoadPersonAction>((event, emit) async {
      await _loadPerson(event, emit);
    });
  }

  Future<void> _loadPerson(LoadPersonAction event, Emitter<FetchResult?> emit) async {
    final url = event.url;
    if (_cache.containsKey(url)) {
      final cachedPersons = _cache[url]!;
      final result = FetchResult(
        isRetrievedFromCache: true,
        persons: cachedPersons.persons,
      );
      if (!emit.isDone) {
        emit(result);
      }
    } else {
      final persons = await getPersons(url.url);
      final fetchResult = FetchResult(
        persons: persons,
        isRetrievedFromCache: false,
      );
      _cache[url] = fetchResult;
      if (!emit.isDone) {
        emit(fetchResult);
      }
    }
  }
}

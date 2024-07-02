import '../imports.dart';

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, FetchResult> _cache = {};
  PersonBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      _loadPerson(event, emit);
    });
  }

  void _loadPerson(LoadPersonAction event, Emitter<FetchResult?> emit) async {
    final url = event.url;
    if (_cache.containsKey(url)) {
      final cachedPersons = _cache[url]!;
      final result = FetchResult(
        isRetrievedFromCache: true,
        persons: cachedPersons.persons,
      );
      emit(result);
    } else {
      final persons = await getPersons(url.url);
      _cache[url] = persons as FetchResult;
      final result = FetchResult(
        persons: persons,
        isRetrievedFromCache: false,
      );
      emit(result);
    }
  }
}

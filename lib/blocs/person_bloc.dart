import 'package:bloc/bloc.dart';
import 'package:statemanager/blocs/bloc_model/fetch_result.dart';
import 'package:statemanager/blocs/bloc_model/load_action.dart';

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, FetchResult> _cache = {};
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
        persons: cachedPersons.persons,
        isRetrievedFromCache: true,
      );
      if (!emit.isDone) {
        emit(result);
      }
    } else {
      final loader = event.loader;
      final persons = await loader(url);
      final fetchResult = FetchResult(
        persons: persons,
        isRetrievedFromCache: false,
      );
      _cache[url] = fetchResult;
      if (!emit.isDone) {
        emit(fetchResult);
      }
    }
    //}
  }
}

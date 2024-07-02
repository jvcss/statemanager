import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:statemanager/models/fetch_result.dart';
import 'package:statemanager/models/load_action.dart';
import 'package:statemanager/models/person_url.dart';
import 'package:statemanager/services/person_service.dart';

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

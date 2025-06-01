import 'dart:convert'
    show Utf8Decoder, jsonDecode;
import 'dart:io'
    show
        HttpClient,
        HttpClientRequest,
        HttpClientResponse;

import 'package:statemanager/extensions/extensions.dart';
import 'package:statemanager/models/models.dart';

typedef SearchTerm = String;

class Api {
  List<Animal>? _animals;
  List<Person>? _persons;

  Future<List<Thing>?> getThings(
      SearchTerm term) async {
    // This method fetches animals and persons from the API
    // and returns a list of things that match the search term.
    if (_animals == null || _persons == null) {
      final animals = await _getJson(
        'http://127.0.0.1:5500/apis/animals.json',
      ).then((json) => json.map(
          (value) => Animal.fromJson(value)));
      final persons = await _getJson(
        'http://127.0.0.1:5500/apis/persons.json',
      ).then((json) => json.map(
          (value) => Person.fromJson(value)));

      _animals = animals.toList();
      _persons = persons.toList();
    }

    if (term.isEmpty) {
      // if the term is empty, return all things
      final allThings = <Thing>[];
      if (_animals != null) {
        allThings.addAll(_animals!);
      }
      if (_persons != null) {
        allThings.addAll(_persons!);
      }
      return allThings;
    }

    return _extractThingsUsingSearchTerm(term);
  }

  List<Thing>? _extractThingsUsingSearchTerm(
      SearchTerm term) {
    final cachedAnimals = _animals;
    final cachedPersons = _persons;

    if (cachedAnimals == null ||
        cachedPersons == null) {
      return null;
    }

    // do it for all properties
    final animals = cachedAnimals
        .where((animal) => animal.matches(term))
        .toList();
    final persons = cachedPersons
        .where((person) => person.matches(term))
        .toList();

    List<Thing> things = [];
    things.addAll(animals);
    things.addAll(persons);
    return things;
  }

  Future<List<dynamic>> _getJson(
      String url) async {
    return HttpClient()
        .getUrl(Uri.parse(url))
        .then((HttpClientRequest request) =>
            request.close())
        .then((HttpClientResponse response) =>
            response
                .transform(const Utf8Decoder())
                .join())
        .then((String jsonString) =>
            jsonDecode(jsonString)
                as List<dynamic>);
  }
}

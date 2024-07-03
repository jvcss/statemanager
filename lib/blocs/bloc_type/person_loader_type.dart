
import 'package:statemanager/models/person.dart';

/// A typedef representing a function that loads a list of persons from a given URL.
///
/// The function takes a [url] parameter and returns a [Future] that resolves to an [Iterable] of [Person] objects.
typedef PersonsLoader = Future<Iterable<Person>> Function(String url);
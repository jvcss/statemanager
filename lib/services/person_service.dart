
import 'dart:convert';
import 'dart:io';

import 'package:statemanager/models/person.dart';

Future<Iterable<Person>> getPersons(String url) async {
  final uri = Uri.parse(url);
  final request = await HttpClient().getUrl(uri);
  final response = await request.close();
  final responseBody = await response.transform(utf8.decoder).join();
  final jsonList = json.decode(responseBody) as List<dynamic>;
  final persons = jsonList.map((e) => Person.fromJson(e));
  return persons;
}

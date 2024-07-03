import '../imports.dart';

Future<Iterable<Person>> getPersons(String url) {
  return HttpClient()
  .getUrl(Uri.parse(url))
  .then((req) => req.close())
  .then((resp) => resp.transform(utf8.decoder).join())
  .then((str) => json.decode(str) as List<dynamic>) // looking for a list of dynamic which can means a forced json typing
  .then((list) => list.map((e) => Person.fromJson(e)));
}

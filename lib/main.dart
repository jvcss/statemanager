import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const Page(title: 'Flutter Demo Home Page'),
      routes: {
        '/': (context) => BlocProvider(
              create: (_) => PersonBloc(),
              child: const PageScreen(),
            ),
        //'/person': (context) => const PersonPage(),
      },
    );
  }
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction extends LoadAction {
  const LoadPersonAction({required this.url}) : super();

  final PersonUrl url;
}

enum PersonUrl {
  person1,
  person2,
}

extension UrlString on PersonUrl {
  String get url {
    switch (this) {
      case PersonUrl.person1:
        return 'https://jsonplaceholder.typicode.com/users/1';
      case PersonUrl.person2:
        return 'https://jsonplaceholder.typicode.com/users/2';
    }
  }
}

@immutable
class Person {
  final String name;
  final int age;
  const Person({
    required this.name,
    required this.age,
  });

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;
}

Future<Iterable<Person>> getPersons(String url) {
  return HttpClient().getUrl(Uri.parse(url)).then((req) => req.close()).then((resp) => resp.transform(utf8.decoder).join()).then((str) => json.decode(str) as List<dynamic>).then((list) => list.map((e) => Person.fromJson(e)));
}

@immutable
class FatchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;
  const FatchResult({
    required this.isRetrievedFromCache,
    required this.persons,
  });

  @override
  String toString() {
    return 'FatchResult{persons: $persons, isRetrievedFromCache: $isRetrievedFromCache}';
  }
}

class PersonBloc extends Bloc<LoadAction, FatchResult?> {
  final Map<PersonUrl, FatchResult> _cache = {};
  PersonBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      _loadPerson(event, emit);
    });
  }

  void _loadPerson(LoadPersonAction event, Emitter<FatchResult?> emit) async {
    final url = event.url;
    if (_cache.containsKey(url)) {
      final cachedPersons = _cache[url]!;
      final result = FatchResult(
        isRetrievedFromCache: true,
        persons: cachedPersons.persons,
      );
      emit(result);
    } else {
      final persons = await getPersons(url.url);
      _cache[url] = persons as FatchResult;
      final result = FatchResult(
        persons: persons,
        isRetrievedFromCache: false,
      );
      emit(result);
    }
  }
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                final f = context.read()<PersonBloc>().add(LoadPersonAction(url: PersonUrl.person1));
              },
              child: const Text('Load json 1'),
            ),
            TextButton(
              onPressed: () {
                final f = context.read()<PersonBloc>().add(LoadPersonAction(url: PersonUrl.person2));
              },
              child: const Text('Load json 2'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:statemanager/blocs/bloc_model/fetch_result.dart';
import 'package:statemanager/blocs/bloc_model/load_action.dart';
import 'package:statemanager/blocs/person_bloc.dart';
import 'package:statemanager/models/person.dart';

const mockPerson1 = [
  Person(age: 1, name: 'John'),
  Person(age: 2, name: 'Doe'),
  Person(name: 'Dani', age: 28),
];

const mockPerson2 = [
  Person(age: 1, name: 'John'),
  Person(age: 2, name: 'Doe'),
  Person(name: 'Dani', age: 28),
];

Future<Iterable<Person>> mockGetPersons1(String _) async => Future.value(mockPerson1);
Future<Iterable<Person>> mockGetPersons2(String _) async => Future.value(mockPerson2);

void main() {
  group('testing bloc', () {
    late PersonBloc personBloc;

    setUp(() {
      personBloc = PersonBloc();
    });

    blocTest<PersonBloc, FetchResult?>(
      'test initial state',
      build: () => personBloc,
      verify: (bloc) => expect(bloc.state, null),
    );

    blocTest<PersonBloc, FetchResult?>(
      'mock retrieving ',
      build: () => personBloc,
      act: (bloc) {
        bloc.add(LoadPersonAction(
          url: 'url1',
          loader: mockGetPersons1,
        ));
      },
      expect: () => [const FetchResult(persons: mockPerson1, isRetrievedFromCache: false)],
    );
  });
}

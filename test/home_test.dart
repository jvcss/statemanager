// import 'dart:typed_data';

// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:statemanager/main.dart';
// import 'package:statemanager/bloc/app/app_bloc.dart';
// import 'package:statemanager/bloc/app/app_event.dart';
// import 'package:statemanager/bloc/app/app_state.dart';

// extension ToList on String {
//   Uint8List toUnit8List() => Uint8List.fromList(codeUnits);
// }

// final txt1 = 'txt1'.toUnit8List();
// final txt2 = 'txt2'.toUnit8List();

// void main() {
//   blocTest<AppBloc, AppState>(
//     'Initial state should be empty',
//     build: () => AppBloc(urls: []),
//     verify: (appBloc) => expect(appBloc.state, const AppState.initialState()),
//   );

//   blocTest<AppBloc, AppState>(
//     'Load valid data and compere',
//     build: () => AppBloc(
//       urls: [],
//       urlPicker: (_) => '',
//       urlLoader: (_) => Future.value(txt1),
//     ),
//     act: (appBloc) => appBloc.add(const LoadNextUrlEvent()),
//     expect: () => [
//       const AppState(isLoading: true, data: null, error: null),
//       AppState(isLoading: false, data: txt1, error: null),
//     ],
//   );

//   blocTest<AppBloc, AppState>(
//     'Load invalid data and compere',
//     build: () => AppBloc(
//       urls: [],
//       urlPicker: (_) => '',
//       urlLoader: (_) => Future.error('error'),
//     ),
//     act: (appBloc) => appBloc.add(const LoadNextUrlEvent()),
//     expect: () => [
//       const AppState(isLoading: true, data: null, error: null),
//       const AppState(isLoading: false, data: null, error: 'error'),
//     ],
//   );

//   blocTest<AppBloc, AppState>(
//     'Load valid data and compere',
//     build: () => AppBloc(
//       urls: [],
//       urlPicker: (_) => '',
//       urlLoader: (_) => Future.value(txt2),
//     ),
//     act: (appBloc) {
//       appBloc.add(const LoadNextUrlEvent()); // 1º
//       appBloc.add(const LoadNextUrlEvent()); // 2º
//     },
//     expect: () => [
//       // 1º
//       const AppState(isLoading: true, data: null, error: null),
//       AppState(isLoading: false, data: txt2, error: null),
//       // 2º
//       const AppState(isLoading: true, data: null, error: null),
//       AppState(isLoading: false, data: txt2, error: null),
//     ],
//   );
// }

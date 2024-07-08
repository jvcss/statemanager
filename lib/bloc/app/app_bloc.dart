import 'dart:async';

import 'package:flutter/services.dart';
import 'package:statemanager/bloc/app/app_event.dart';
import 'package:statemanager/bloc/app/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() {
    final randomIndex = math.Random().nextInt(length);
    return elementAt(randomIndex);
  }
}

class AppBloc extends Bloc<AppEvent, AppState> {
  // ignore: unused_element
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  AppBloc({
    required Iterable<String> urls,
    AppBlocRandomUrlPicker? urlPicker,
    Duration? waitBeforeLoading,
  }) : super(
          const AppState.initialState(),
        ) {
    on<LoadNextUrlEvent>(
      (event, emit) async {
        emit(const AppState(
          isLoading: true,
          data: null,
          error: null,
        ));

        final url = (urlPicker ?? _pickRandomUrl)(urls);
        try {
          if (waitBeforeLoading != null){
            await Future.delayed(waitBeforeLoading);
          }
          final bundle = NetworkAssetBundle(Uri.parse(url));
          final data = (await bundle.load(url)).buffer.asUint8List();
          emit(AppState(
            isLoading: false,
            data: data,
            error: null,
          ));
        } catch (e) {
          emit(AppState(
            isLoading: false,
            data: null,
            error: e,
          ));
        }
      },
    );
  }

  FutureOr<void> _onLoadNextUrl(
    LoadNextUrlEvent event,
    Emitter<AppState> emit,
  ) {}
}

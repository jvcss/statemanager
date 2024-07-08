import 'dart:async';

import 'package:flutter/services.dart';
import 'package:statemanager/bloc/app/app_event.dart';
import 'package:statemanager/bloc/app/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanager/extensions/start_with.dart';

typedef AppBlocRandomUrlPicker = String Function(Iterable<String> allUrls);
typedef UrlLoader = Future<Uint8List> Function(String url);

class AppBloc extends Bloc<AppEvent, AppState> {
  // ignore: unused_element
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  Future<Uint8List> _loadUrl(String url) async {
    final bundle = await NetworkAssetBundle(Uri.parse(url)).load(url);
    final data = bundle.buffer.asUint8List();
    return data;
  }

  AppBloc({
    required Iterable<String> urls,
    AppBlocRandomUrlPicker? urlPicker,
    Duration? waitBeforeLoading,
    UrlLoader? urlLoader,
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
          if (waitBeforeLoading != null) {
            await Future.delayed(waitBeforeLoading);
          }
          final data = await (urlLoader ?? _loadUrl)(url);
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

  // if you want to use the `urlPicker` fro the constructor
  // you can't isolate the call for the on<LoadNextUrlEvent> method
  // so this is a literal limitation of the architecture
  FutureOr<void> _onLoadNextUrl(
    LoadNextUrlEvent event,
    Emitter<AppState> emit,
  ) {}
}

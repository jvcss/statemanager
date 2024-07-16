import 'package:flutter/foundation.dart' show debugPrint;
import 'package:redux/redux.dart';
import 'package:statemanager/redux/app_state.dart';

void loggerMiddleware(Store<MyState> store, dynamic action, NextDispatcher next) {
  debugPrint('dispatching $action');
  next(action);
  debugPrint('next state ${store.state}');
}

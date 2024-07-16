import 'package:redux/redux.dart';
import 'package:statemanager/redux/app_state.dart';

void loggerMiddleware(Store<MyState> store, dynamic action, NextDispatcher next) {
  print('dispatching $action');
  next(action);
  print('next state ${store.state}');
}

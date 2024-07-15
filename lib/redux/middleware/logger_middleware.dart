import 'package:redux/redux.dart';
import '../app_state.dart';

void loggerMiddleware(Store<State> store, dynamic action, NextDispatcher next) {
  print('dispatching $action');
  next(action);
  print('next state ${store.state}');
}

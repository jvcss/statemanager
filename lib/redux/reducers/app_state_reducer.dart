import 'package:redux/redux.dart' as redux;
import '../app_state.dart';
import '../actions/item_actions.dart';
import 'item_reducer.dart';
import 'filter_reducer.dart';

State appStateReducer(State state, MyAction action) {
  return State(
    items: itemsReducer(state.items, action as ItemAction),
    filter: itemFilterReducer(state, action),
  );
}

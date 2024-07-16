import 'package:statemanager/redux/app_state.dart';
import 'package:statemanager/redux/reducers/filter_reducer.dart';
import 'package:statemanager/redux/reducers/item_reducer.dart';

MyState appStateReducer(MyState state,  action) {
  return MyState(
    items: itemsReducer(state.items, action),
    filter: itemFilterReducer(state, action),
  );
}

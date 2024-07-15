import 'package:statemanager/redux/actions/filter_actions.dart';
import 'package:statemanager/redux/actions/item_actions.dart';
import 'package:statemanager/redux/app_state.dart';

ActionOptions itemFilterReducer(State oldState, MyAction action) {
  if (action is ChangeFilterTypeAction) {
    return action.filter;
  } else {
    return oldState.filter;
  }
}

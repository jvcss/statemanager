import 'package:flutter/foundation.dart';
import 'package:statemanager/redux/actions/item_actions.dart';

enum ActionOptions {
  all,
  shortText,
  longText,
}

@immutable
class ChangeFilterTypeAction extends MyAction {
  final ActionOptions filter;

  const ChangeFilterTypeAction(this.filter);
}

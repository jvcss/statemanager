import 'package:flutter/foundation.dart';
import 'actions/item_actions.dart';
import 'actions/filter_actions.dart';

@immutable
class MyState {
  final Iterable<String> items;
  final ActionOptions filter;

  const MyState({
    required this.items,
    required this.filter,
  });

  Iterable<String> get filteredItems {
    switch (filter) {
      case ActionOptions.all:
        return items;
      case ActionOptions.shortText:
        return items.where((item) => item.length <= 3);
      case ActionOptions.longText:
        return items.where((item) => item.length > 10);
    }
  }
}

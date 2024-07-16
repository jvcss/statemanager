import 'package:redux/redux.dart' as redux;
import 'package:statemanager/redux/actions/item_actions.dart';

extension AddRemoveItems<T> on Iterable<T> {
  Iterable<T> operator +(T item) => followedBy([item]);
  Iterable<T> operator -(T item) => where((i) => i != item);
}

Iterable<String> addItemReducer(Iterable<String> items, AddItemAction action) {
  return items + action.item;
}

Iterable<String> removeItemReducer(Iterable<String> items, RemoveItemAction action) {
  return items - action.item;
}

redux.Reducer<Iterable<String>> itemsReducer = redux.combineReducers<Iterable<String>>([
  redux.TypedReducer<Iterable<String>, AddItemAction>(addItemReducer).call,
  redux.TypedReducer<Iterable<String>, RemoveItemAction>(removeItemReducer).call,
]);

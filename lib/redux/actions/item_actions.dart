import 'package:flutter/foundation.dart';

@immutable
abstract class MyAction {
  const MyAction();
}

@immutable
abstract class ItemAction extends MyAction {
  final String item;

  const ItemAction({required this.item});
}

@immutable
class AddItemAction extends ItemAction {
  const AddItemAction({required super.item});
}

@immutable
class RemoveItemAction extends ItemAction {
  const RemoveItemAction({required super.item});
}

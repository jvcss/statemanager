import 'package:flutter/material.dart';
import 'package:statemanager/api.dart';
import 'package:uuid/uuid.dart';

class ApiProvider extends InheritedWidget {
  final API api;
  final String id;

  ApiProvider({
      super.key,
      required this.api,
      required super.child,
    }): id = const Uuid().v4();

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return id != oldWidget.id;
  }

  static ApiProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>();
  }
}

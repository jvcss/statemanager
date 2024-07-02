import 'package:flutter/material.dart';
import 'person_url.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction extends LoadAction {
  const LoadPersonAction({required this.url}) : super();

  final PersonUrl url;
}

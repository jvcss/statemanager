import 'package:flutter/foundation.dart';
import 'package:statemanager/blocs/bloc_type/person_loader_type.dart';
//

// It
@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction implements LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonAction({required this.url, required this.loader}) : super();
}

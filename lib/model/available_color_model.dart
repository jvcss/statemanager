import 'package:flutter/material.dart';
import 'package:statemanager/util/countables.dart';
import 'dart:developer' as developer show log;

class AvailableColorsWidget extends InheritedModel<EnumColor> {
  const AvailableColorsWidget({
    super.key,
    required super.child,
    required this.availableColors1,
    required this.availableColors2,
  });

  final MaterialColor availableColors1;
  final MaterialColor availableColors2;

  static AvailableColorsWidget of(BuildContext context, EnumColor aspect) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(
      context,
      aspect: aspect,
    )!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    // só atualiza se as cores disponíveis mudarem
    // only update if the available colors change
    developer.log('updateShouldNotify');
    return availableColors1 != oldWidget.availableColors1 || availableColors2 != oldWidget.availableColors2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorsWidget oldWidget,
    Set<EnumColor> dependencies,
  ) {
    developer.log('updateShouldNotifyDependent $dependencies');
    return dependencies.contains(EnumColor.one) && availableColors1 != oldWidget.availableColors1;
  }
}

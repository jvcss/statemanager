import 'package:flutter/material.dart';
import 'package:statemanager/util/couters.dart';

class AvailableColorsWidget extends InheritedModel<AvailableColors> {
  const AvailableColorsWidget({
    super.key,
    required super.child,
    required this.availableColors,
    required this.availableColors2,
  });

  final AvailableColors availableColors;
  final AvailableColors availableColors2;

  static AvailableColorsWidget of(BuildContext context, AvailableColors aspect) {
    return InheritedModel.inheritFrom<AvailableColorsWidget>(
      context,
      aspect: aspect,
    )!;
  }

  @override
  bool updateShouldNotify(AvailableColorsWidget oldWidget) {
    return availableColors != oldWidget.availableColors;
  }

  @override
  bool updateShouldNotifyDependent(
    AvailableColorsWidget oldWidget,
    Set<AvailableColors> dependencies,
  ) {
    return dependencies.contains(AvailableColors.one) && availableColors != oldWidget.availableColors;
  }
}

import 'package:flutter/material.dart';
import 'package:statemanager/model/available_color_model.dart';
import 'package:statemanager/util/countables.dart';
import 'dart:developer' as developer show log;

class ColorWidget extends StatelessWidget {
  final EnumColor colorWidget;
  const ColorWidget({super.key, required this.colorWidget});

  @override
  Widget build(BuildContext context) {
    switch (colorWidget) {
      case EnumColor.one:
        developer.log('ColorWidget: availableColor1 EnumColor.one');
      case EnumColor.two:
        developer.log('ColorWidget: availableColor1 EnumColor.two');
    }
    final provider = AvailableColorsWidget.of(context, colorWidget);
    return Container(
      width: 100,
      height: 100,
      color: colorWidget == EnumColor.one ? provider.availableColors1 : provider.availableColors2,
    );
  }
}

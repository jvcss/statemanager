import 'package:flutter/material.dart';
import 'package:statemanager/model/available_color_model.dart';
import 'package:statemanager/util/countables.dart';
import 'dart:developer' as developer show log;

class ColorWidget extends StatelessWidget {
  final EnumColor availableColor1;
  final EnumColor availableColor2;
  const ColorWidget({super.key, required this.availableColor1, required this.availableColor2});

  @override
  Widget build(BuildContext context) {
    final selectedWidgetColor1 = AvailableColorsWidget.of(context, availableColor1);
    final selectedWidgetColor2 = AvailableColorsWidget.of(context, availableColor2);
    switch (availableColor1) {
      case EnumColor.one:
        developer.log('ColorWidget: availableColor1 EnumColor.one');
      case EnumColor.two:
        developer.log('ColorWidget: availableColor1 EnumColor.two');
    }
    switch (availableColor2) {
      case EnumColor.one:
        developer.log('AvailableColorsWidget: selectedWidgetColor1 EnumColor.one');
      case EnumColor.two:
        developer.log('AvailableColorsWidget: selectedWidgetColor1 EnumColor.two');
    }
    if (selectedWidgetColor1.availableColors1 != availableColor1) {
      return Container(
        color: selectedWidgetColor1.availableColors1,
        width: 100,
        height: 100,
      );
    } else if (selectedWidgetColor2.availableColors2 != availableColor2) {
      return Container(
        color: selectedWidgetColor2.availableColors2,
        width: 100,
        height: 100,
      );
    } else {
      return Container(
        color: Colors.black,
        width: 100,
        height: 100,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:statemanager/model/available_color_model.dart';
import 'package:statemanager/pages/components/color_widget.dart';
import 'package:statemanager/util/countables.dart';
import 'package:statemanager/util/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var _color1 = Colors.yellow;
  var _color2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Color Widget'),
          centerTitle: true,
        ),
        body: AvailableColorsWidget(
          availableColors1: _color1,
          availableColors2: _color2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ColorWidget(
                    colorWidget: EnumColor.one,
                  ),
                  ColorWidget(
                    colorWidget: EnumColor.two,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _color1 = colors.random();
                      });
                    },
                    child: const Text('Change color 1'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _color2 = colors.random();
                      });
                    },
                    child: const Text('Change color 2'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

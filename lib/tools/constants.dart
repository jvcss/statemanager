import 'package:flutter/material.dart' show Color, Widget, Icons;

import 'package:statemanager/models/models.dart';

import 'package:statemanager/widgets/widgets.dart'
    show
        BubbleChartWidget,
        ScatterChartWidget,
        TreeMapChartWidget,
        GaugeChartWidget,
        SingleValueCardWidget;

List<Widget> listCharts = [
  const TreeMapChartWidget(
    width: 200,
    height: 200,
  ),
  const ScatterChartWidget(
    width: 200,
    height: 300,
  ),
  const BubbleChartWidget(
    width: 200,
    height: 300,
  ),
  const GaugeChartWidget(
    width: 200,
    height: 300,
  ),
  const SingleValueCardWidget(
    width: 200,
    height: 200,
    data: SingleValueData(
      value: 'R\$ 100',
      label: 'Total',//fff0f2
      color: Color(0xFF4CAF50),//Color(0xFFfff0f2),//
      icon: Icons.check_circle,
    ),
  ),
];

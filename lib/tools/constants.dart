
import 'package:flutter/widgets.dart' show Widget;

import 'package:statemanager/widgets/widgets.dart' show BubbleChartWidget, ScatterChartWidget, TreeMapChartWidget;

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
];

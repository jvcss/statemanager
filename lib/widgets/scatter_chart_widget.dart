import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:statemanager/models/point_data.dart';

class ScatterChartWidget extends StatefulWidget {
  final List<PointData>? data;
  const ScatterChartWidget({super.key, this.data});

  @override
  ScatterChartWidgetState createState() => ScatterChartWidgetState();
}

class ScatterChartWidgetState extends State<ScatterChartWidget> {
  late Future<List<PointData>> _futureData;

  List<PointData> mockData = [
    PointData(x: 1, y: 2),
    PointData(x: 2, y: 4),
    PointData(x: 3, y: 1),
    PointData(x: 4, y: 3),
  ];

  @override
  void initState() {
    super.initState();
    _futureData = _loadData();
  }

  Future<List<PointData>> _loadData() async {
    try {
      return widget.data ?? mockData;
    } catch (e) {
      return mockData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PointData>>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data ?? mockData;
        return _buildChart(data);
      },
    );
  }
  // todo: add params
  Widget _buildChart(List<PointData> data) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ScatterChart(
        ScatterChartData(
          scatterSpots: data
              .map((d) => ScatterSpot(d.x.toDouble(), d.y.toDouble()))
              .toList(),
          minX: 0,
          maxX: 5,
          minY: 0,
          maxY: 5,
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}


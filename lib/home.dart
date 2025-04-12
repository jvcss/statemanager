
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:statemanager/tools/constants.dart';
import 'package:statemanager/widgets/widgets.dart';

import 'package:statemanager/models/models.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _refillGraphs() {
    // some random x y values
    final random = math.Random();
    final xValues = List.generate(10, (_) => random.nextInt(10) + 1);
    final yValues = List.generate(10, (_) => random.nextInt(10) + 1);
    final sizeValues = List.generate(10, (_) => random.nextDouble() * 100 + 1);
    setState(() {
      listCharts = [
        TreeMapChartWidget(
          width: 200,
          height: 200,
          data: [
            TreeMapData(
                label: 'A',
                value: sizeValues[random.nextInt(10)],
                color: Colors.blue),
            TreeMapData(
                label: 'B',
                value: sizeValues[random.nextInt(10)],
                color: Colors.green),
            TreeMapData(
                label: 'C',
                value: sizeValues[random.nextInt(10)],
                color: Colors.red),
            TreeMapData(
                label: 'D',
                value: sizeValues[random.nextInt(10)],
                color: Colors.orange),
          ],
        ),
        ScatterChartWidget(
          width: 200,
          height: 300,
          data: [
            ScatterData(
                x: xValues[random.nextInt(10)],
                y: yValues[random.nextInt(10)],
                color: Colors.blue),
            ScatterData(
                x: xValues[random.nextInt(10)],
                y: yValues[random.nextInt(10)],
                color: Colors.green),
            ScatterData(
                x: xValues[random.nextInt(10)],
                y: yValues[random.nextInt(10)],
                color: Colors.red),
            ScatterData(
                x: xValues[random.nextInt(10)],
                y: yValues[random.nextInt(10)],
                color: Colors.orange),
          ],
        ),
        BubbleChartWidget(
          width: 200,
          height: 300,
          data: [
            BubbleData(
                x: xValues[random.nextInt(10)],
                y: yValues[random.nextInt(10)],
                size: 20,
                color: Colors.blue),
            BubbleData(
                x: xValues[random.nextInt(10)],
                y: yValues[random.nextInt(10)],
                size: 30,
                color: Colors.green),
            BubbleData(
                x: xValues[random.nextInt(10)],
                y: yValues[random.nextInt(10)],
                size: 10,
                color: Colors.red),
            BubbleData(
                x: xValues[random.nextInt(10)],
                y: yValues[random.nextInt(10)],
                size: 25,
                color: Colors.orange),
          ],
        ),
        GaugeChartWidget(
          width: 50,
          height: 50,
          data: GaugeData(
            label: 'Gauge',
            color: Colors.blue,
            backgroundColor: Colors.grey,
            strokeWidth: 20.0,
            showText: true,
            value: random.nextDouble() * 100,
          ),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: listCharts.length,
        itemBuilder: (context, index) {
          return listCharts[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refillGraphs,
        tooltip: 'Refill',
        child: const Icon(Icons.add),
      ),
    );
  }
}

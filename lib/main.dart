import 'package:flutter/material.dart';
import 'package:statemanager/models/point_data.dart';
import 'package:statemanager/widgets/scatter_chart_widget.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87),
        useMaterial3: true,
      ),
      home: Card(
        color: Colors.white,
        
        child: ScatterChartWidget(
          width: 400,
          height: 300,
          data: [
            PointData(x: 1, y: 2, color: Colors.blue),
            PointData(x: 2, y: 2, color: Colors.green),
            PointData(x: 3, y: 1, color: Colors.red),
            PointData(x: 2, y: 3, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}

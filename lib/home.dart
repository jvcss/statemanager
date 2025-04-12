import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:statemanager/tools/constants.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _refillGraphs() {
    setState(() {
      listCharts = [
        const TreeMapChartWidget(
          width: 200,
          height: 200,
          data: [
            TreeMapData(label: 'A', value: 30, color: Colors.blue),
            TreeMapData(label: 'B', value: 20, color: Colors.green),
            TreeMapData(label: 'C', value: 10, color: Colors.red),
            TreeMapData(label: 'D', value: 40, color: Colors.orange),
          ],
        ),
        const ScatterChartWidget(
          width: 200,
          height: 300,
          data: [
            PointData(x: 1, y: 2, color: Colors.blue),
            PointData(x: 2, y: 4, color: Colors.green),
            PointData(x: 3, y: 1, color: Colors.red),
            PointData(x: 4, y: 3, color: Colors.orange),
          ],
        ),
        const BubbleChartWidget(
          width: 200,
          height: 300,
          data: [
            BubbleData(x: 1, y: 2, size: 20, color: Colors.blue),
            BubbleData(x: 2, y: 4, size: 30, color: Colors.green),
            BubbleData(x: 3, y: 1, size: 10, color: Colors.red),
            BubbleData(x: 4, y: 3, size: 25, color: Colors.orange),
          ],
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
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// --- TreeMap Chart Widget --

class TreeMapData {
  final String label;
  final double value;
  final Color color;
  const TreeMapData(
      {required this.label, required this.value, required this.color});
}

class TreeMapChartWidget extends StatefulWidget {
  const TreeMapChartWidget({
    super.key,
    this.width,
    this.height,
    this.data,
    this.showLabels = true,
    this.borderRadius = 8.0,
  });

  final double? width;
  final double? height;
  final List<TreeMapData>? data;
  final bool showLabels;
  final double borderRadius;

  @override
  State<TreeMapChartWidget> createState() => _TreeMapChartWidgetState();
}

class _TreeMapChartWidgetState extends State<TreeMapChartWidget> {
  final List<TreeMapData> mockData = const [
    TreeMapData(label: 'A', value: 30, color: Colors.blue),
    TreeMapData(label: 'B', value: 20, color: Colors.green),
    TreeMapData(label: 'C', value: 10, color: Colors.red),
    TreeMapData(label: 'D', value: 40, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ?? mockData;
    final total = chartData.fold<double>(0, (sum, d) => sum + d.value);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // ignore: unused_local_variable
              double xOffset = 0;
              return Row(
                children: chartData.map((d) {
                  final widthFraction = d.value / total;
                  final itemWidth = constraints.maxWidth * widthFraction;
                  final widgetItem = Container(
                    width: itemWidth,
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      color: d.color,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                    alignment: Alignment.center,
                    child: widget.showLabels
                        ? Text(
                            d.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  );
                  xOffset += itemWidth;
                  return widgetItem;
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

// --- Scatter Chart Widget --

class PointData {
  final int x;
  final int y;
  final Color color;
  const PointData({required this.x, required this.y, required this.color});
}

class ScatterChartWidget extends StatefulWidget {
  const ScatterChartWidget({
    super.key,
    this.width,
    this.height,
    this.data,
    this.dotRadius = 8,
    this.dotOpacity = 0.7,
    this.showBorder = true,
  });

  final double? width;
  final double? height;
  final List<PointData>? data;
  final double dotRadius;
  final double dotOpacity;
  final bool showBorder;

  @override
  State<ScatterChartWidget> createState() => _ScatterChartWidgetState();
}

class _ScatterChartWidgetState extends State<ScatterChartWidget> {
  final List<PointData> mockData = const [
    PointData(x: 1, y: 2, color: Colors.blue),
    PointData(x: 2, y: 4, color: Colors.green),
    PointData(x: 3, y: 1, color: Colors.red),
    PointData(x: 4, y: 3, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ?? mockData;
    final maxX = chartData.map((d) => d.x).reduce(math.max).toDouble() + 1;
    final maxY = chartData.map((d) => d.y).reduce(math.max).toDouble() + 1;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomPaint(
            painter: _ScatterChartPainter(
              data: chartData,
              maxX: maxX,
              maxY: maxY,
              radius: widget.dotRadius,
              opacity: widget.dotOpacity,
              showBorder: widget.showBorder,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class _ScatterChartPainter extends CustomPainter {
  final List<PointData> data;
  final double maxX;
  final double maxY;
  final double radius;
  final double opacity;
  final bool showBorder;

  _ScatterChartPainter({
    required this.data,
    required this.maxX,
    required this.maxY,
    required this.radius,
    required this.opacity,
    required this.showBorder,
  }) : assert(opacity >= 0.0 && opacity <= 1.0,
            'Opacity must be between 0.0 and 1.0');

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final point in data) {
      final dx = (point.x / maxX) * size.width;
      final dy = size.height - (point.y / maxY) * size.height;
      paint.color = point.color.withAlpha((opacity * 255).toInt());
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }

    if (showBorder) {
      final borderPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// --- Bubble Chart Widget --

class BubbleData {
  final int x;
  final int y;
  final double size;
  final Color color;
  const BubbleData(
      {required this.x,
      required this.y,
      required this.size,
      required this.color});
}

class BubbleChartWidget extends StatefulWidget {
  const BubbleChartWidget({
    super.key,
    this.width,
    this.height,
    this.data,
    this.opacity = 0.6,
    this.showBorder = true,
    this.maxBubbleSize = 30.0,
  });

  final double? width;
  final double? height;
  final List<BubbleData>? data;
  final double opacity;
  final bool showBorder;
  final double maxBubbleSize;

  @override
  State<BubbleChartWidget> createState() => _BubbleChartWidgetState();
}

class _BubbleChartWidgetState extends State<BubbleChartWidget> {
  final List<BubbleData> mockData = const [
    BubbleData(x: 1, y: 2, size: 20, color: Colors.blue),
    BubbleData(x: 2, y: 4, size: 30, color: Colors.green),
    BubbleData(x: 3, y: 1, size: 10, color: Colors.red),
    BubbleData(x: 4, y: 3, size: 25, color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ?? mockData;
    final maxX = chartData.map((d) => d.x).reduce(math.max).toDouble() + 1;
    final maxY = chartData.map((d) => d.y).reduce(math.max).toDouble() + 1;
    final maxSize = chartData.map((d) => d.size).reduce(math.max);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomPaint(
            painter: _BubbleChartPainter(
              data: chartData,
              maxX: maxX,
              maxY: maxY,
              maxSize: maxSize,
              maxBubbleSize: widget.maxBubbleSize,
              opacity: widget.opacity,
              showBorder: widget.showBorder,
            ),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class _BubbleChartPainter extends CustomPainter {
  final List<BubbleData> data;
  final double maxX;
  final double maxY;
  final double maxSize;
  final double maxBubbleSize;
  final double opacity;
  final bool showBorder;

  _BubbleChartPainter({
    required this.data,
    required this.maxX,
    required this.maxY,
    required this.maxSize,
    required this.maxBubbleSize,
    required this.opacity,
    required this.showBorder,
  }): assert(opacity >= 0.0 && opacity <= 1.0,
            'Opacity must be between 0.0 and 1.0');

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final point in data) {
      final dx = (point.x / maxX) * size.width;
      final dy = size.height - (point.y / maxY) * size.height;
      final radius = (point.size / maxSize) * maxBubbleSize;
      paint.color = point.color.withAlpha((opacity * 255).toInt());
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }

    if (showBorder) {
      final borderPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

import 'package:flutter/material.dart';
import 'package:statemanager/models/tree_map_data.dart';

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

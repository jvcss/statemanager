
import 'package:flutter/material.dart';
import 'package:statemanager/models/funnel_data.dart';

class FunnelChartWidget extends StatefulWidget {
  const FunnelChartWidget({
    super.key,
    this.width,
    this.height,
    this.data,
    this.showLabels = true,
    this.gap = 8.0,
  });

  final double? width;
  final double? height;
  final List<FunnelData>? data;
  final bool showLabels;
  final double gap;

  @override
  State<FunnelChartWidget> createState() => _FunnelChartWidgetState();
}

class _FunnelChartWidgetState extends State<FunnelChartWidget> {
  final List<FunnelData> mockData = const [
    FunnelData(label: 'Visitantes', value: 1000, color: Colors.blue),
    FunnelData(label: 'Leads', value: 600, color: Colors.green),
    FunnelData(label: 'Propostas', value: 300, color: Colors.orange),
    FunnelData(label: 'Vendas', value: 100, color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = widget.data ?? mockData;
    final maxValue =
        chartData.map((d) => d.value).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: chartData.map((d) {
              final widthFraction = d.value / maxValue;
              return Padding(
                padding: EdgeInsets.only(bottom: widget.gap),
                child: Container(
                  width: widget.width != null
                      ? widget.width! * widthFraction
                      : double.infinity,
                  height: (widget.height ?? 300) / (chartData.length + 1),
                  decoration: BoxDecoration(
                    color: d.color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: widget.showLabels
                      ? Text(
                          d.label,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'Outfit',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
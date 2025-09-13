# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\bubble_data.dart

import 'dart:ui' show Color;

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

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\funnel_data.dart


import 'dart:ui' show Color;

class FunnelData {
  final String label;
  final double value;
  final Color color;

  const FunnelData({
    required this.label,
    required this.value,
    required this.color,
  });
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\gauge_data.dart

import 'package:flutter/material.dart';

class GaugeData {
  final double value;
  final double maxValue;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final bool showText;
  final String? label;

  const GaugeData({
    required this.value,
    this.maxValue = 100,
    this.color = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.strokeWidth = 20.0,
    this.showText = true,
    this.label,
  });

  double get percent => (value / maxValue).clamp(0.0, 1.0);
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\matrix_data.dart

import 'dart:ui' show Color;

class MatrixCell {
  final String label;
  final int indent;

  const MatrixCell({required this.label, this.indent = 0});
}

class MatrixRow {
  final List<MatrixCell> cells;

  const MatrixRow(this.cells);
}

class MatrixData {
  final List<String> headers;
  final List<MatrixRow> rows;
  final Color headerColor;
  final Color rowColor;

  const MatrixData({
    required this.headers,
    required this.rows,
    this.headerColor = const Color(0xFF1565C0),
    this.rowColor = const Color(0xFFF5F5F5),
  });
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\models.dart

export 'bubble_data.dart';
export 'scatter_data.dart';
export 'tree_map_data.dart';
export 'gauge_data.dart';
export 'single_card_data.dart';
export 'multi_card_data.dart';
export 'funnel_data.dart';
export 'table_data.dart';
export 'matrix_data.dart';

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\multi_card_data.dart


import 'package:flutter/widgets.dart' show IconData, Color;

class MultiCardData {
  final List<MapEntry<String, String>> items;
  final bool horizontal;
  final Color color;
  final IconData? icon;

  const MultiCardData({
    required this.items,
    this.horizontal = false,
    this.color = const Color(0xFF1E88E5),
    this.icon,
  });
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\scatter_data.dart

import 'dart:ui' show Color;

class ScatterData {
  final int x;
  final int y;
  final Color color;
  const ScatterData({required this.x, required this.y, required this.color});
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\single_card_data.dart


import 'package:flutter/widgets.dart' show IconData, Color;

class SingleCardData {
  final String value;
  final String? label;
  final IconData? icon;
  final Color color;

  const SingleCardData({
    required this.value,
    this.label,
    this.icon,
    this.color = const Color(0xFF3B82F6),
  });
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\table_data.dart



import 'dart:ui' show Color;

class TableData {
  final List<String> headers;
  final List<List<String>> rows;
  final Color headerColor;
  final Color rowColor;

  const TableData({
    required this.headers,
    required this.rows,
    this.headerColor = const Color(0xFF1E88E5),
    this.rowColor = const Color(0xFFF5F5F5),
  });
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\models\tree_map_data.dart

import 'dart:ui' show Color;

class TreeMapData {
  final String label;
  final double value;
  final Color color;
  const TreeMapData(
      {required this.label, required this.value, required this.color});
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\tools\constants.dart

import 'package:flutter/material.dart' show Color, Widget, Icons;

import 'package:statemanager/models/models.dart';

import 'package:statemanager/widgets/widgets.dart';

List<Widget> listCharts = [
  const FunnelChartWidget(
    width: 800,
    height: 400,
  ),
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
    data: SingleCardData(
      value: 'R\$ 100',
      label: 'Total', //fff0f2
      color: Color(0xFF4CAF50), //Color(0xFFfff0f2),//
      icon: Icons.check_circle,
    ),
  ),
  const MultiValueCardWidget(
    width: 200,
    height: 280,
    data: MultiCardData(
      items: [
        MapEntry('Receita', 'R\$ 20K'),
        MapEntry('Lucro', 'R\$ 8K'),
        MapEntry('Crescimento', '12%'),
      ],
      color: Color(0xFF2E7D32),
      icon: Icons.dashboard,
      horizontal: false,
    ),
  ),
  const TableChartWidget(
    width: 200,
    height: 300,
    data: TableData(
      headers: ['Nome', 'Valor', 'Categoria'],
      rows: [
        ['Produto A', 'R\$ 120K', 'EletrÃ´nicos'],
        ['Produto B', 'R\$ 90K', 'Casa'],
        ['Produto C', 'R\$ 45K', 'Papelaria'],
      ],
    ),
  ),
  const MatrixChartWidget(
    width: 200,
    height: 300,
    data: MatrixData(
      headers: ['Categoria', 'Valor'],
      rows: [
        MatrixRow([
          MatrixCell(label: 'Receita', indent: 0),
          MatrixCell(label: 'R\$ 100K')
        ]),
        MatrixRow([
          MatrixCell(label: 'â–¸ Vendas', indent: 1),
          MatrixCell(label: 'R\$ 80K')
        ]),
        MatrixRow([
          MatrixCell(label: 'â–¸ ServiÃ§os', indent: 1),
          MatrixCell(label: 'R\$ 20K')
        ]),
        MatrixRow([
          MatrixCell(label: 'Despesas', indent: 0),
          MatrixCell(label: 'R\$ 60K')
        ]),
        MatrixRow([
          MatrixCell(label: 'â–¸ Operacionais', indent: 1),
          MatrixCell(label: 'R\$ 40K')
        ]),
        MatrixRow([
          MatrixCell(label: 'â–¸ Administrativas', indent: 1),
          MatrixCell(label: 'R\$ 20K')
        ]),
      ],
    ),
  )
];

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\bubble_chart_widget.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:statemanager/models/bubble_data.dart';

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

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\funnel_chart_widget.dart


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

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\gauge_chart_widget.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:statemanager/models/gauge_data.dart';


class GaugeChartWidget extends StatefulWidget {
  const GaugeChartWidget({
    super.key,
    this.width = 200.0,
    this.height = 300.0,
    this.data,
    this.radius,
  });

  final double width;
  final double height;
  final double? radius;
  final GaugeData? data;

  @override
  State<GaugeChartWidget> createState() => _GaugeChartWidgetState();
}

class _GaugeChartWidgetState extends State<GaugeChartWidget> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data ??
        const GaugeData(
          label: 'Gauge Chart',
          color: Colors.blue,
          backgroundColor: Colors.grey,
          strokeWidth: 20.0,
          showText: true,
          value: 0.7,
          maxValue: 1.0,
        );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final resolvedRadius = widget.radius ??
                  (math.min(constraints.maxWidth, constraints.maxHeight * 2) / 2 - data.strokeWidth / 2);
              return CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: _GaugePainter(
                  percent: data.percent,
                  color: data.color,
                  backgroundColor: data.backgroundColor,
                  strokeWidth: data.strokeWidth,
                  radius: resolvedRadius,
                ),
                child: Center(
                  child: data.showText
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FittedBox(
                              child: Text(
                                '${(data.percent * 100).toInt()}%',
                                style: Theme.of(context)
                                    .textTheme.headlineMedium!
                                    .copyWith(
                                      fontFamily: 'Outfit',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            if (data.label != null)
                              FittedBox(
                                child: Text(
                                  data.label!,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double percent;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final double radius;

  _GaugePainter({
    required this.percent,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);
    canvas.drawArc(
        rect, startAngle, sweepAngle * percent, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\matrix_chart_widget.dart

import 'package:flutter/material.dart';
import 'package:statemanager/models/models.dart' show MatrixData, MatrixRow, MatrixCell;

class MatrixChartWidget extends StatefulWidget {
  const MatrixChartWidget({
    super.key,
    this.width,
    this.height,
    this.data,
  });

  final double? width;
  final double? height;
  final MatrixData? data;

  @override
  State<MatrixChartWidget> createState() => _MatrixChartWidgetState();
}

class _MatrixChartWidgetState extends State<MatrixChartWidget> {
  final MatrixData mockData = const MatrixData(
    headers: ['Categoria', 'Valor'],
    rows: [
      MatrixRow([
        MatrixCell(label: 'Receita', indent: 0),
        MatrixCell(label: 'R\$ 100K')
      ]),
      MatrixRow([
        MatrixCell(label: 'â–¸ Vendas', indent: 1),
        MatrixCell(label: 'R\$ 80K')
      ]),
      MatrixRow([
        MatrixCell(label: 'â–¸ ServiÃ§os', indent: 1),
        MatrixCell(label: 'R\$ 20K')
      ]),
      MatrixRow([
        MatrixCell(label: 'Despesas', indent: 0),
        MatrixCell(label: 'R\$ 60K')
      ]),
      MatrixRow([
        MatrixCell(label: 'â–¸ Operacionais', indent: 1),
        MatrixCell(label: 'R\$ 40K')
      ]),
      MatrixRow([
        MatrixCell(label: 'â–¸ Administrativas', indent: 1),
        MatrixCell(label: 'R\$ 20K')
      ]),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final matrix = widget.data ?? mockData;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(matrix.headerColor),
                dataRowColor: WidgetStateProperty.all(matrix.rowColor),
                headingTextStyle:
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                dataTextStyle: Theme.of(context).textTheme.bodyMedium,
                columns: matrix.headers
                    .map((header) => DataColumn(label: Text(header)))
                    .toList(),
                rows: matrix.rows.map((row) {
                  return DataRow(
                    cells: row.cells.map((cell) {
                      return DataCell(
                        Padding(
                          padding: EdgeInsets.only(left: cell.indent * 16.0),
                          child: Text(cell.label),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\multi_value_chart_widget.dart

import 'package:flutter/material.dart';

import 'package:statemanager/models/multi_card_data.dart';


class MultiValueCardWidget extends StatefulWidget {
  const MultiValueCardWidget({
    super.key,
    this.width,
    this.height,
    this.data,
  });

  final double? width;
  final double? height;
  final MultiCardData? data;

  @override
  State<MultiValueCardWidget> createState() => _MultiValueCardWidgetState();
}

class _MultiValueCardWidgetState extends State<MultiValueCardWidget> {
  final MultiCardData mockData = const MultiCardData(
    items: [
      MapEntry('Receita', 'R\$ 20K'),
      MapEntry('Lucro', 'R\$ 8K'),
      MapEntry('Crescimento', '12%'),
    ],
    color: Color(0xFF2E7D32),
    icon: Icons.dashboard,
    horizontal: false,
  );

  @override
  Widget build(BuildContext context) {
    final data = widget.data ?? mockData;

    final content = data.items.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.key,
            style: 
            Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontFamily: 'Outfit',
                  color: Colors.white70,
                ),
          ),
          FittedBox(
            child: Text(
              entry.value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
    }).toList();

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        color: data.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.icon != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Icon(data.icon, color: Colors.white, size: 28),
                ),
              data.horizontal
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: content,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: content,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\scatter_chart_widget.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:statemanager/models/scatter_data.dart';

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
  final List<ScatterData>? data;
  final double dotRadius;
  final double dotOpacity;
  final bool showBorder;

  @override
  State<ScatterChartWidget> createState() => _ScatterChartWidgetState();
}

class _ScatterChartWidgetState extends State<ScatterChartWidget> {
  final List<ScatterData> mockData = const [
    ScatterData(x: 1, y: 2, color: Colors.blue),
    ScatterData(x: 2, y: 4, color: Colors.green),
    ScatterData(x: 3, y: 1, color: Colors.red),
    ScatterData(x: 4, y: 3, color: Colors.orange),
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
  final List<ScatterData> data;
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

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\single_value_chart_widget.dart

import 'package:flutter/material.dart';

import 'package:statemanager/models/single_card_data.dart';

class SingleValueCardWidget extends StatelessWidget {
  const SingleValueCardWidget({
    super.key,
    required this.data,
    this.width = 200,
    this.height = 120,
  });

  final double width;
  final double height;
  final SingleCardData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: data.color,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (data.icon != null)
                Icon(data.icon, color: Colors.white, size: 28),
              FittedBox(
                child: Text(
                  data.value,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              if (data.label != null)
                Text(
                  data.label!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Outfit',
                        color: Colors.white70,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\table_chart_widget.dart

import 'package:flutter/material.dart';
import 'package:statemanager/models/models.dart' show TableData;

class TableChartWidget extends StatefulWidget {
  const TableChartWidget({
    super.key,
    this.width,
    this.height,
    this.data,
  });

  final double? width;
  final double? height;
  final TableData? data;

  @override
  State<TableChartWidget> createState() => _TableChartWidgetState();
}

class _TableChartWidgetState extends State<TableChartWidget> {
  final TableData mockData = const TableData(
    headers: ['Nome', 'Valor', 'Categoria'],
    rows: [
      ['Produto A', 'R\$ 120K', 'EletrÃ´nicos'],
      ['Produto B', 'R\$ 90K', 'Casa'],
      ['Produto C', 'R\$ 45K', 'Papelaria'],
    ],
  );

  @override
  Widget build(BuildContext context) {
    final table = widget.data ?? mockData;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(table.headerColor),
            dataRowColor: WidgetStateProperty.all(table.rowColor),
            headingTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            dataTextStyle: Theme.of(context).textTheme.bodyMedium,
            columns: table.headers
                .map((header) => DataColumn(label: Text(header)))
                .toList(),
            rows: table.rows
                .map((row) => DataRow(
                      cells: row.map((cell) => DataCell(Text(cell))).toList(),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\tree_map_chart_widget.dart

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

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\widgets\widgets.dart

export 'bubble_chart_widget.dart';
export 'scatter_chart_widget.dart';
export 'tree_map_chart_widget.dart';
export 'gauge_chart_widget.dart';
export 'single_value_chart_widget.dart';
export 'multi_value_chart_widget.dart';
export 'funnel_chart_widget.dart';
export 'table_chart_widget.dart';
export 'matrix_chart_widget.dart';

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\home.dart


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
          width: 200,
          height: 300,
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

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\lib\main.dart

import 'package:flutter/material.dart';
import 'package:statemanager/home.dart';

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
      home: const HomePage(title: 'BI Visuals'),
    );
  }
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\test\widget_test.dart

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:statemanager/main.dart';

void main() {
  testWidgets('View Graph', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());
    // Verify 
  });
}

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\analysis_options.yaml

# This file configures the analyzer, which statically analyzes Dart code to
# check for errors, warnings, and lints.
#
# The issues identified by the analyzer are surfaced in the UI of Dart-enabled
# IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be
# invoked from the command line by running `flutter analyze`.

# The following line activates a set of recommended lints for Flutter apps,
# packages, and plugins designed to encourage good coding practices.
include: package:flutter_lints/flutter.yaml

linter:
  # The lint rules applied to this project can be customized in the
  # section below to disable rules from the `package:flutter_lints/flutter.yaml`
  # included above or to enable additional rules. A list of all available lints
  # and their documentation is published at https://dart.dev/lints.
  #
  # Instead of disabling a lint rule for the entire project in the
  # section below, it can also be suppressed for a single line of code
  # or a specific dart file by using the `// ignore: name_of_lint` and
  # `// ignore_for_file: name_of_lint` syntax on the line or in the file
  # producing the lint.
  rules:
    avoid_print: true  # Uncomment to disable the `avoid_print` rule
    prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule

# Additional information about this file can be found at
# https://dart.dev/guides/language/analysis-options

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\devtools_options.yaml

description: This file stores settings for Dart & Flutter DevTools.
documentation: https://docs.flutter.dev/tools/devtools/extensions#configure-extension-enablement-states
extensions:

# ---- File Name Path: C:\Users\jvcsm\Documents\flutter\statemanager\pubspec.yaml

name: statemanager
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: '>=3.3.4 <4.0.0'

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.6
  uuid: ^4.4.0
  path: ^1.9.0
  flutter_hooks: ^0.20.5
  collection: ^1.18.0
  async: ^2.11.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/assets-and-images/#from-packages

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages


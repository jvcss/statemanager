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
      ['Produto A', 'R\$ 120K', 'Eletrônicos'],
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

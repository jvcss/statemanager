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
        MatrixCell(label: '▸ Vendas', indent: 1),
        MatrixCell(label: 'R\$ 80K')
      ]),
      MatrixRow([
        MatrixCell(label: '▸ Serviços', indent: 1),
        MatrixCell(label: 'R\$ 20K')
      ]),
      MatrixRow([
        MatrixCell(label: 'Despesas', indent: 0),
        MatrixCell(label: 'R\$ 60K')
      ]),
      MatrixRow([
        MatrixCell(label: '▸ Operacionais', indent: 1),
        MatrixCell(label: 'R\$ 40K')
      ]),
      MatrixRow([
        MatrixCell(label: '▸ Administrativas', indent: 1),
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

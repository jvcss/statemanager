import 'package:flutter/material.dart';

extension ToListScreen<T> on Iterable<T> {
  Widget toListScreen() {
    return ItarableListScreen(iterable: this);
  }
}

class ItarableListScreen<T> extends StatelessWidget {
  final Iterable<T> iterable;

  const ItarableListScreen({
    super.key,
    required this.iterable,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: iterable.length,
      itemBuilder: (context, index) {
        final item = iterable.elementAt(index);
        return ListTile(
          title: Text(item.toString()),
        );
      },
    );
  }
}

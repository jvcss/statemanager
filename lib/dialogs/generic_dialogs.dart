import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder<T> options,
}){
  final dialogOptions = options();
  return showDialog<T?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: dialogOptions.entries.map((entry) {
          return TextButton(
            onPressed: () => 
            // ignore: unnecessary_null_comparison
            entry != null ? Navigator.of(context).pop(entry.value) : Navigator.of(context).pop() ,
            child: Text(entry.key),
          );
        }).toList(),
      );
    },
  );
}
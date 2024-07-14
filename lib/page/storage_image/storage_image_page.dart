import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageImagePage extends StatelessWidget {
  final Reference ref;
  const StorageImagePage({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
        future: ref.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Placeholder(
              fallbackHeight: 200,
              fallbackWidth: 200,
              strokeWidth: 0,
            );
          }
          if (snapshot.hasError) {
            return const Icon(Icons.error);
          }
          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
            );
          }
          return const SizedBox();
        });
  }
}

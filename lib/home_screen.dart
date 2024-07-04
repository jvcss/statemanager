import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:statemanager/extensions.dart';

const url = 'https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final image = useMemoized(
      () => NetworkAssetBundle(Uri.parse(url))
          .load(
            url,
          )
          .then((
            data,
          ) =>
              data.buffer.asUint8List())
          .then(
            (
              data,
            ) =>
                Image.memory(
              data,
            ),
          ),
    );

    final snap = useFuture(image);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Column(
          children: [snap.data].compactMap().toList(),
        ));
  }
}

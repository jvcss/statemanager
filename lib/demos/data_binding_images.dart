

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive_native/rive_native.dart' as rive;

import '../app.dart';
import '../rive_player.dart';

class ExampleDataBindingImages extends StatefulWidget {
  const ExampleDataBindingImages({super.key});

  @override
  State<ExampleDataBindingImages> createState() => _ExampleBasicState();
}

class _ExampleBasicState extends State<ExampleDataBindingImages> {
  late rive.ViewModelInstance viewModelInstance;

  Future<Uint8List> loadBundleAsset(int index) async {
    final ByteData data =
        await rootBundle.load('assets/images/databound_image_$index.jpg');
    return data.buffer.asUint8List();
  }

  Future<void> _clearImage() async {
    final imageProperty = viewModelInstance.image('bound_image')!;
    imageProperty.value = null;
    setState(() {});
  }

  Future<void> _swapImage(int index) async {
    final imageProperty = viewModelInstance.image('bound_image')!;
    final bytes = await loadBundleAsset(index);
    final renderImage =
        await RiveExampleApp.getCurrentFactory.decodeImage(bytes);
    if (renderImage != null) {
      imageProperty.value = renderImage;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RivePlayer(
            asset: 'assets/databinding_images.riv',
            autoBind: true,
            withViewModelInstance: (viewModelInstance) {
              this.viewModelInstance = viewModelInstance;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _clearImage,
                child: const Text('Clear image'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _swapImage(1);
                },
                child: const Text('Swap image 1'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _swapImage(2);
                },
                child: const Text('Swap image 2'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

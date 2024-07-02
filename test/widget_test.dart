import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:path/path.dart' as path;
import 'package:statemanager/main.dart';
import 'package:statemanager/cubit/random_names_cubit.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  ScreenshotController screenshotController = ScreenshotController();

  // Future<void> captureScreenshot(String fileName) async {
  // String directoryPath = path.join(Directory.current.path, 'screenshots');

  // try {
  //print('Creating directory: $directoryPath');
  //   await Directory(directoryPath).create(recursive: true);
  //   print('Directory created successfully.');
  // } catch (e) {
  //   print('Error creating directory: $e');
  //   return;
  // }

  //String directoryPath = Directory.current.path;

  // String filePath = path.join(directoryPath, '$fileName.png');

  //   try {
  //     final image = await screenshotController.capture(
  //       pixelRatio: 3.0,
  //       delay: const Duration(milliseconds: 10),
  //     );
  //     if (image != null) {
  //       final file = File(filePath);
  //       await file.writeAsBytes(image);
  //       print('Screenshot saved to $filePath');
  //     } else {
  //       print('Failed to capture screenshot.');
  //     }
  //   } catch (e) {
  //     print('Error capturing or saving screenshot: $e');
  //   }
  // }
  testWidgets('Stream of Nullable Strings Test', (WidgetTester tester) async {
    final cubit = NamesCubit();
    cubit.generateRandomName();
    final streamController = StreamController<String?>();

    final subscription = cubit.stream.listen((name) {
      streamController.add(name);
    });

    await tester.pumpWidget(Screenshot(
      controller: screenshotController,
      child: MyApp(
        streamController: streamController,
      ),
    ));

    await tester.pumpAndSettle();
    //await captureScreenshot('stream_initial_state');

    // Additional interactions and assertions...
    // await tester.tap(find.byType(FloatingActionButton));
    // await tester.pumpAndSettle();
    // await captureScreenshot('after_fab_tap');

    subscription.cancel();
    streamController.close();
  });
}

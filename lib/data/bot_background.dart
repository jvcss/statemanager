import 'package:flutter_background/flutter_background.dart';

Future<void> initializeBackgroundService() async {
  var androidConfig = const FlutterBackgroundAndroidConfig(
    notificationTitle: 'Bot Manager',
    notificationText: 'Atualizando bots em tempo real.',
    notificationImportance: AndroidNotificationImportance.normal,
  );

  await FlutterBackground.initialize(androidConfig: androidConfig);
  FlutterBackground.enableBackgroundExecution();
}

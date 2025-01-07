import 'package:flutter/foundation.dart';
import 'package:statemanager/model/bot.dart';
import 'package:workmanager/workmanager.dart';
import 'package:hive/hive.dart';

const updateBotsTask = 'update_bots_task';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {


    debugPrint('Task executada: $task'); // Verifique se esse log aparece
    if (task == updateBotsTask) {
      final box = await Hive.openBox<Bot>('bots');
      for (var bot in box.values) {
        bot.executionTime += 10;
        box.put(bot.name, bot);
      }
    }
    return Future.value(true);
  });
}

Future<void> initializeWorkManager() async {
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true,);
  await Workmanager().registerPeriodicTask(
    'crytosafe.update_bots_task',
    updateBotsTask,
    frequency: const Duration(minutes: 15),
  );
}

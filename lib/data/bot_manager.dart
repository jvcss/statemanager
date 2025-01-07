import 'package:flutter/foundation.dart';
import 'package:statemanager/model/bot.dart';
import 'package:workmanager/workmanager.dart';
import 'package:hive/hive.dart';

const updateBotsTask = 'update_bots_task';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    debugPrint('Task executada: $task');

    if (task == updateBotsTask) {
      final box = await Hive.openBox<Bot>('bots');
      for (var bot in box.values) {
        bot.executionTime += 10; // Atualiza tempo
        box.put(bot.name, bot);
        debugPrint('Bot atualizado: ${bot.name}, Tempo: ${bot.executionTime}');
      }
      await box.close(); // Fecha o box após o uso
    }

    return Future.value(true);
  });
}

Future<void> initializeWorkManager() async {
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  await Workmanager().registerPeriodicTask(
    'crytosafe.update_bots_task',
    updateBotsTask,
    frequency: const Duration(minutes: 15), // Mínimo permitido pelo WorkManager
  );
}

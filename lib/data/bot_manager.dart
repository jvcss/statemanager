import 'package:statemanager/model/bot.dart';
import 'package:workmanager/workmanager.dart';
import 'package:hive/hive.dart';

const updateBotsTask = 'update_bots_task';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
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
  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    'Work.manager.Periodic.Task.1.minute',
    updateBotsTask,
    frequency: const Duration(minutes: 1),
  );
}

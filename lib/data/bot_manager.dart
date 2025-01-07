import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:statemanager/model/bot.dart';
import 'package:workmanager/workmanager.dart';
import 'package:hive/hive.dart';

const updateBotsTask = 'update_bots_task';
@pragma(
    'vm:entry-point') // Obrigatório se o App estiver ofuscado ou usando Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    debugPrint('Task executada: $task');

    // Inicializa o Hive no contexto do WorkManager
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path); // Inicializa Hive com o caminho correto
    Hive.registerAdapter(BotAdapter()); // Registra o adaptador novamente

    if (task == updateBotsTask) {
      final box = await Hive.openBox<Bot>('bots'); // Abre a box
      for (var bot in box.values) {
        bot.executionTime += 10; // Atualiza tempo
        box.put(bot.name, bot); // Salva as alterações
        debugPrint('Bot atualizado: ${bot.name}, Tempo: ${bot.executionTime}');
      }
      await box.close(); // Fecha a box após o uso
    }

    return Future.value(true); // Indica que a tarefa foi concluída
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

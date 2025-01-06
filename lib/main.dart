import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:statemanager/app.dart';
import 'package:statemanager/data/bot_background.dart';
import 'package:statemanager/data/bot_manager.dart';
import 'package:statemanager/model/bot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(
    BotAdapter(),
  );
  final botBox = await Hive.openBox<Bot>('bots');
  // Inicializa o Flutter Background
  await initializeBackgroundService();
  // Inicializa o WorkManager
  await initializeWorkManager();
  runApp(App(botBox: botBox));
}

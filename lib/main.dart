import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:statemanager/app.dart';
import 'package:statemanager/model/bot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BotAdapter());
  final botBox = await Hive.openBox<Bot>('bots');
  runApp(App(botBox: botBox));
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:statemanager/model/bot.dart';
import 'package:statemanager/ui/home_page.dart';
import 'bloc/bot_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BotAdapter());
  final botBox = await Hive.openBox<Bot>('bots');
  runApp(App(botBox: botBox));
}

class App extends StatelessWidget {
  final Box<Bot> botBox;

  const App({super.key, required this.botBox});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => BotBloc(botBox),
        child: const HomePage(),
      ),
    );
  }
}

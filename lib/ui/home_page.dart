import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:statemanager/model/bot.dart';
import '../bloc/bot_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _updateTimer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      final box = Hive.box<Bot>('bots');
      for (var bot in box.values) {
        bot.executionTime += 1; // Incrementa tempo manualmente
        await box.put(bot.name, bot);
      }
      setState(() {}); // Atualiza UI
    });
  }

  @override
  Widget build(BuildContext context) {
    final botBloc = context.read<BotBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Bot Manager')),
      body: BlocBuilder<BotBloc, BotState>(
        buildWhen: (previous, current) => previous.bots != current.bots,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              botBloc.add(UpdateBots());
            },
            child: ListView.builder(
              itemCount: state.bots.length,
              itemBuilder: (context, index) {
                final bot = state.bots[index];
                return ListTile(
                  title: Text(bot.name),
                  subtitle: Text('Tempo de Execução: ${bot.executionTime}s'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      botBloc.add(DeleteBot(bot.name));
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final controller = TextEditingController();
              return AlertDialog(
                title: const Text('Adicionar Bot'),
                content: TextField(
                  controller: controller,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      botBloc.add(AddBot(controller.text));
                      Navigator.pop(context);
                    },
                    child: const Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

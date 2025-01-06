import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bot_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final botBloc = context.read<BotBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Bot Manager')),
      body: BlocBuilder<BotBloc, BotState>(
        builder: (context, state) {
          return ListView.builder(
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

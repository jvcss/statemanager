import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:statemanager/model/bot.dart';

class BotEvent {}

class AddBot extends BotEvent {
  final String name;

  AddBot(this.name);
}

class UpdateBotTime extends BotEvent {
  final String botName;

  UpdateBotTime(this.botName);
}

class UpdateBots extends BotEvent {
  UpdateBots();
}

class DeleteBot extends BotEvent {
  final String botName;

  DeleteBot(this.botName);
}

class BotState {
  final List<Bot> bots;

  BotState(this.bots);
}

class BotBloc extends Bloc<BotEvent, BotState> {
  final Box<Bot> botBox;

  BotBloc(this.botBox)
      : super(
          BotState(botBox.values.toList()),
        ) {
    on<AddBot>((event, emit) {
      final newBot = Bot(name: event.name);
      botBox.put(event.name, newBot);
      emit(BotState(botBox.values.toList()));
    });

    on<UpdateBotTime>((event, emit) {
      final bot = botBox.get(event.botName);
      if (bot != null) {
        bot.executionTime += 1;
        botBox.put(event.botName, bot);
        emit(BotState(botBox.values.toList()));
      }
    });

    on<UpdateBots>((event, emit) {
      for (var bot in botBox.values) {
        bot.executionTime += 1;
        botBox.put(bot.name, bot);
      }
      emit(BotState(botBox.values.toList()));
    });

    on<DeleteBot>((event, emit) {
      botBox.delete(event.botName);
      emit(BotState(botBox.values.toList()));
    });
  }
}

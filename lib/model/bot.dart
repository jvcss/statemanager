import 'package:hive/hive.dart';

part 'bot.g.dart';

@HiveType(typeId: 0)
class Bot {
  @HiveField(0)
  final String name;

  @HiveField(1)
  int executionTime; // Time in seconds

  Bot({required this.name, this.executionTime = 0});
}

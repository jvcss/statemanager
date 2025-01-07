import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void main() => runApp(const MyApp());

const simpleTaskKey = 'simpleTask';
const rescheduledTaskKey = 'rescheduledTask';
const failedTaskKey = 'failedTask';
const simpleDelayedTask = 'simpleDelayedTask';
const simplePeriodicTask =
    'simplePeriodicTask';
const simplePeriodic1HourTask =
    'simplePeriodic1HourTask';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case simpleTaskKey:
        debugPrint('$simpleTaskKey was executed. inputData = $inputData');
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('test', true);
        debugPrint("Bool from prefs: ${prefs.getBool("test")}");
        break;
      case rescheduledTaskKey:
        final key = inputData!['key']!;
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('unique-$key')) {
          debugPrint('has been running before, task is successful');
          return true;
        } else {
          await prefs.setBool('unique-$key', true);
          debugPrint('reschedule task');
          return false;
        }
      case failedTaskKey:
        debugPrint('failed task');
        return Future.error('failed');
      case simpleDelayedTask:
        debugPrint('$simpleDelayedTask was executed');
        break;
      case simplePeriodicTask:
        debugPrint('$simplePeriodicTask was executed');
        break;
      case simplePeriodic1HourTask:
        debugPrint('$simplePeriodic1HourTask was executed');
        break;
      case Workmanager.iOSBackgroundTask:
        debugPrint('The iOS background fetch was triggered');
        Directory? tempDir = await getTemporaryDirectory();
        String? tempPath = tempDir.path;
        debugPrint(
            'You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath');
        break;
    }

    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter WorkManager Example'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Plugin initialization',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ElevatedButton(
                  child: const Text('Start the Flutter background service'),
                  onPressed: () {
                    debugPrint('WorkManager service started');
                    Workmanager().initialize(
                      callbackDispatcher,
                      isInDebugMode: true,
                    );
                  },
                ),
                const SizedBox(height: 16),

                //This task runs once.
                //Most likely this will trigger immediately
                ElevatedButton(
                  child: const Text('Register OneOff Task'),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      simpleTaskKey,
                      simpleTaskKey,
                      inputData: <String, dynamic>{
                        'int': 1,
                        'bool': true,
                        'double': 1.0,
                        'string': 'string',
                        'array': [1, 2, 3],
                      },
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Register rescheduled Task'),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      rescheduledTaskKey,
                      rescheduledTaskKey,
                      inputData: <String, dynamic>{
                        'key': Random().nextInt(64000),
                      },
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Register failed Task'),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      failedTaskKey,
                      failedTaskKey,
                    );
                  },
                ),
                //This task runs once
                //This wait at least 10 seconds before running
                ElevatedButton(
                    child: const Text('Register Delayed OneOff Task'),
                    onPressed: () {
                      Workmanager().registerOneOffTask(
                        simpleDelayedTask,
                        simpleDelayedTask,
                        initialDelay: const Duration(seconds: 10),
                      );
                    }),
                const SizedBox(height: 18),
                // This task runs periodically
                // It will wait at least 10 seconds before its first launch
                // Since we have not provided a frequency it will be the default 15 minutes
                ElevatedButton(
                    onPressed: Platform.isAndroid
                        ? () {
                            Workmanager().registerPeriodicTask(
                              simplePeriodicTask,
                              simplePeriodicTask,
                              initialDelay: const Duration(seconds: 1),
                              frequency: const Duration(minutes: 15),
                            );
                          }
                        : null,
                    child: const Text('Register Periodic Task (Android)')),

                // This task runs periodically
                // It will run about every hour
                ElevatedButton(
                    onPressed: Platform.isAndroid
                        ? () {
                            Workmanager().registerPeriodicTask(
                              simplePeriodicTask,
                              simplePeriodic1HourTask,
                              frequency: const Duration(seconds: 10),
                            );
                          }
                        : null,
                    child: const Text(
                        'Register 10 seconds Periodic Task (Android)')),
                const SizedBox(height: 16),

                // This will cancel all tasks
                Text(
                  'Task cancellation',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ElevatedButton(
                  child: const Text('Cancel All'),
                  onPressed: () async {
                    await Workmanager().cancelAll();
                    debugPrint('Cancel all tasks completed');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

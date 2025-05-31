import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // memoize is an object you hold onto until a point arrives where you no longer need it.
    // This is useful for expensive calculations or objects that you want to reuse.
    // final subject = useMemoized(() {
    //   BehaviorSubject<String> subject = BehaviorSubject<String>();
    //   return subject;
    // }, [key]);
    // create a BehaviorSubject every time widget is rebuilt
    final subject = useMemoized(
        () => BehaviorSubject<String>(), [key]);
    // dispose the old BehaviorSubject when the widget is rebuilt
    useEffect(() => subject.close, [subject]);

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: StreamBuilder<String>(
            stream: subject.stream
                .distinct()
                .debounceTime(
                  const Duration(seconds: 1),
                ),
            initialData: 'God like',
            builder: (context, snapshot) {
              // why use snapshot.data ?? snapshot.requireData?
              // snapshot.data can be null if the stream has not emitted any data yet.
              // snapshot.requireData will throw an error if the stream has not emitted any data yet.
              // This is useful to avoid null checks in the widget tree.
              final text = snapshot.data ??
                  snapshot.requireData;
              return Text(
                'You typed: ${text.isEmpty ? 'Nothing' : text}',
                style:
                    const TextStyle(fontSize: 20),
              );
            },
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Enter text',
              border: OutlineInputBorder(),
            ),
            onChanged: subject.sink.add,
          ),
        ),
      ),
    );
  }
}

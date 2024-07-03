import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanager/blocs/bloc_model/fetch_result.dart';
import 'package:statemanager/blocs/bloc_model/load_action.dart';
import 'package:statemanager/blocs/person_bloc.dart';
import 'package:statemanager/services/person_service.dart';
import 'package:statemanager/utils/extensions.dart';

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  void timer(BuildContext context) {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      context.read<PersonBloc>().add(const LoadPersonAction(url: person1, loader: getPersons));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                context.read<PersonBloc>().add(const LoadPersonAction(url: person1, loader: getPersons));
              },
              child: const Text('Load json 1'),
            ),
            TextButton(
              onPressed: () {
                context.read<PersonBloc>().add(const LoadPersonAction(url: person2, loader: getPersons));
              },
              child: const Text('Load json 2'),
            ),
            BlocBuilder<PersonBloc, FetchResult?>(
              buildWhen: (previousResult, currentResult) {
                return previousResult?.persons != currentResult?.persons;
              },
              builder: (context, fatchResult) {
                var persons = fatchResult?.persons;
                if (persons == null) {
                  return const Placeholder();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (context, index) {
                      final person = persons[index]?.name;
                      return ListTile(
                        title: Text(
                          person!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          timer(context),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

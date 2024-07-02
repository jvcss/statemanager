import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/person_bloc.dart';
import '../models/load_action.dart';
import '../models/person_url.dart';

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                final f = context.read<PersonBloc>().add(LoadPersonAction(url: PersonUrl.person1));
              },
              child: const Text('Load json 1'),
            ),
            TextButton(
              onPressed: () {
                final f = context.read<PersonBloc>().add(LoadPersonAction(url: PersonUrl.person2));
              },
              child: const Text('Load json 2'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

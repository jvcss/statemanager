import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanager/bloc/app/app_bloc.dart';
import 'package:statemanager/bloc/app/app_event.dart';
import 'package:statemanager/bloc/app/app_state.dart';
import 'package:statemanager/extensions/start_with.dart';

class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({super.key});

  void startUpdatingBloc(BuildContext context) {
    final stream = Stream.periodic(const Duration(seconds: 20), (_) {
      return const LoadNextUrlEvent();
    });

    stream.startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(builder: (context, state) {
        if (state.error != null) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else if (state.data != null) {
          return Image.memory(state.data!, fit: BoxFit.fitHeight);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

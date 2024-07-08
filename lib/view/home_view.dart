import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanager/bloc/app/bottom_bloc.dart';
import 'package:statemanager/bloc/app/top_bloc.dart';
import 'package:statemanager/models/constants.dart';
import 'package:statemanager/view/app_bloc_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TopBloc>(
            create: (_) => TopBloc(
              waitBeforeLoading: const Duration(seconds: 5),
              urls: images,
            ),
          ),
          BlocProvider<BottomBloc>(
            create: (_) => BottomBloc(
              waitBeforeLoading: const Duration(seconds: 5),
              urls: images,
            ),
          ),
        ],
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppBlocView<TopBloc>(),
            AppBlocView<BottomBloc>(),
          ],
        ),
      ),
    ));
  }
}

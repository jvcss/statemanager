import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const url = 'https://images.pexels.com/photos/346529/pexels-photo-346529.jpeg';

enum Action {
  rotateLeft,
  rotateRight,
  moreVisible,
  lessVisible,
}

@immutable
class State {
  final double angle;
  final double alpha;

  const State({
    required this.angle,
    required this.alpha,
  });

  const State.zero()
      : alpha = 1,
        angle = 0;

  State rotateLeft() {
    return copyWith(angle: angle - 10, opacity: alpha);
  }

  State rotateRight() {
    return copyWith(angle: angle + 10, opacity: alpha);
  }

  State moreVisible() {
    return copyWith(angle: angle, opacity: min(alpha + 0.1, 1.0));
  }

  State lessVisible() {
    return copyWith(angle: angle, opacity: max(alpha - 0.1, 0.0));
  }

  State copyWith({required double angle, required double opacity}) {
    return State(
      angle: angle,
      alpha: opacity,
    );
  }
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.moreVisible:
      return oldState.moreVisible();
    case Action.lessVisible:
      return oldState.lessVisible();
    case null:
      return oldState;
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(
      reducer,
      initialState: const State.zero(),
      initialAction: null,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Opacity(
              opacity: store.state.alpha,
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(store.state.angle / 360),
                child: Image.network(
                  url,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => store.dispatch(Action.rotateLeft),
                    child: const Icon(Icons.rotate_left),
                  ),
                  ElevatedButton(
                    onPressed: () => store.dispatch(Action.rotateRight),
                    child: const Icon(Icons.rotate_right),
                  ),
                  ElevatedButton(
                    onPressed: () => store.dispatch(Action.lessVisible),
                    child: const Icon(Icons.visibility_off_outlined),
                  ),
                  ElevatedButton(
                    onPressed: () => store.dispatch(Action.moreVisible),
                    child: const Icon(Icons.visibility_outlined),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

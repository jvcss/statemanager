import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' as hooks; // ! needs to name this one.
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:statemanager/redux/actions/filter_actions.dart';
import 'package:statemanager/redux/actions/item_actions.dart';
import 'package:statemanager/redux/app_state.dart';
import 'package:statemanager/redux/reducers/app_state_reducer.dart';
class HomePage extends hooks.HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Store(
      appStateReducer,
      initialState: const MyState(
        items: [],
        filter: ActionOptions.all,
      ),
    );
    final textCon = hooks.useTextEditingController();

    return Scaffold(
      body: StoreProvider(
          store: store,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      store.dispatch(const ChangeFilterTypeAction(
                        ActionOptions.all,
                      ));
                    },
                    child: const Text('All'),
                  ),
                  TextButton(
                    onPressed: () {
                      store.dispatch(const ChangeFilterTypeAction(
                        ActionOptions.shortText,
                      ));
                    },
                    child: const Text('Short Text'),
                  ),
                  TextButton(
                    onPressed: () {
                      store.dispatch(const ChangeFilterTypeAction(
                        ActionOptions.longText,
                      ));
                    },
                    child: const Text('Long Text'),
                  ),
                ],
              ),
              TextField(
                controller: textCon,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      store.dispatch(AddItemAction(item: textCon.text));
                      textCon.clear();
                    },
                    child: const Text('Add Item'),
                  ),
                  TextButton(
                    onPressed: () {
                      store.dispatch(RemoveItemAction(item: textCon.text));
                      textCon.clear();
                    },
                    child: const Text('Remove Item'),
                  ),
                ],
              ),
              StoreConnector<MyState, Iterable<String>>(
                converter: (store) => store.state.filteredItems,
                builder: (context, items) {
                  return Column(
                    children: items.map((e) => Text(e)).toList(),
                  );
                },
              ),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:statemanager/add_contact_page.dart';
import 'package:statemanager/contact_singleton.dart';
import 'package:statemanager/contact_model.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'State Manager 101',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 37, 168, 107)),
          useMaterial3: true,
        ),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const ContacstPage(),
          '/createContact': (BuildContext context) => const CreateContact(),
        });
  }
}

class ContacstPage extends StatelessWidget {
  const ContacstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Contacts List'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (context, value, child) {
          final List<Contact> actualListContant = value;
          if (actualListContant.isEmpty) {
            return const Center(
              child: Text('No contacts found'),
            );
          }
          return ListView.builder(
            itemCount: actualListContant.length,
            itemBuilder: (BuildContext context, int index) {
              final contact = actualListContant[index];
              return Dismissible(
                key: ValueKey(contact.uuid),
                onDismissed: (direction) {
                  ContactBook().removeContact(contact);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Theme.of(context).colorScheme.surface,
                    borderOnForeground: true,
                    borderRadius: BorderRadius.circular(16),
                    elevation: 6,
                    child: ListTile(
                      title: Text(
                        contact.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/createContact');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

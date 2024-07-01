import 'package:flutter/material.dart';
import 'package:statemanager/contact.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 3, 195, 105)),
        useMaterial3: true,
      ),
      home: const NotesPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key, required this.title});

  final String title;

  @override
  State<NotesPage> createState() => NotesPageState();
}

class NotesPageState extends State<NotesPage> {
  int _counter = 0;
  TextEditingController controllerNewContact = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    controllerNewContact.dispose();
    super.dispose();
  }

  Widget createContact(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controllerNewContact,
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Reset'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: Container(
                  //padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.primary),
                  ),
                  child: ListView.builder(
                    itemCount: ContactBook().length,
                    itemBuilder: (BuildContext context, int index) {
                      final Contact? contact = ContactBook().getContact(index);
                      return ListTile(
                        title: Text(
                          contact?.name ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onTap: () {
                          setState(() {
                            ContactBook().removeContact(contact!);
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            const Text(
              'Variable view managed:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controllerNewContact,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (String value) {
                  setState(() {
                    ContactBook().addContact(Contact(name: value));
                    controllerNewContact.clear();
                  });
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Create Contact'),
                content: CreateContact(controllerNewContact: controllerNewContact),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        ContactBook().addContact(Contact(name: controllerNewContact.text));
                        controllerNewContact.clear();
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Create'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateContact extends StatelessWidget {
  final TextEditingController controllerNewContact;
  const CreateContact({super.key, required this.controllerNewContact});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controllerNewContact,
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Reset'),
        ),
      ],
    );
  }
}

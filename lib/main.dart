import 'package:flutter/material.dart';
import 'package:statemanager/contact.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 37, 168, 107)),
        useMaterial3: true,
      ),
      home: const ContacstPage(),
      routes:  <String, WidgetBuilder> {
        '/': (BuildContext context) => const ContacstPage(),
        '/createContact': (BuildContext context) => CreateContact(controllerNewContact: TextEditingController()),
      }
    ),
  );
}

class ContacstPage extends StatelessWidget {
  const ContacstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Contacts List'),
      ),
      body: ListView.builder(
        itemCount: ContactBook().length,
        itemBuilder: (BuildContext context, int index) {
          final Contact? contact = ContactBook().getContact(index);
          if (contact == null) {
            return const ListTile(
              title: Text('empty'),
            );
          }
          return ListTile(
            title: Text(
              contact.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/createContact');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateContact extends StatefulWidget {
  final TextEditingController controllerNewContact;
  const CreateContact({super.key, required this.controllerNewContact});

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Create Contact'),
      ),
      body: Column(
        children: [
          TextField(
            controller: widget.controllerNewContact,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

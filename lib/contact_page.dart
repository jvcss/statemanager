import 'package:flutter/material.dart';
import 'package:statemanager/contact_singleton.dart';

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
      body: ListView.builder(
        prototypeItem: const ListTile(title: Text('---------')),
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
        onPressed: () async {
          await Navigator.pushNamed(context, '/createContact');
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
        centerTitle: true,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Create',
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}

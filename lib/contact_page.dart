import 'package:flutter/material.dart';
import 'package:statemanager/contact_singleton.dart';

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
          ContactBook().addContact(Contact(name: widget.controllerNewContact.text));
          Navigator.pop(context);
        },
        tooltip: 'Create',
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}

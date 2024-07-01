import 'package:flutter/material.dart';
import 'package:statemanager/contact_model.dart';
import 'package:statemanager/contact_singleton.dart';

class CreateContact extends StatefulWidget {
  
  const CreateContact({super.key});

  @override
  State<CreateContact> createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact> {
  final TextEditingController controllerNewContact = TextEditingController();

  @override
  void dispose() {
    controllerNewContact.dispose();
    super.dispose();
  }

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
            controller: controllerNewContact,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ContactBook().addContact(Contact(name: controllerNewContact.text));
          Navigator.pop(context);
        },
        tooltip: 'Create',
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}

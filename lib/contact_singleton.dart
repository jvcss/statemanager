import 'package:flutter/material.dart';
import 'package:statemanager/contact_model.dart';

class ContactBook extends ValueNotifier<List<Contact>> {
  
  ContactBook.sharedInstance() : super(<Contact>[]);

  static final ContactBook _instance = ContactBook.sharedInstance();
  factory ContactBook() => _instance;

  List<Contact> get contacts => value;

  int get length => value.length;

  void addContact(Contact contact) {
    final List<Contact> contacts = value;
    contacts.add(contact);
    //value = contacts;
    notifyListeners();
  }

  void removeContact(Contact contact) {
    if (!value.contains(contact)) {
      return;
    }
    value.remove(contact);
    notifyListeners();
  }

  void clearContacts() {
    value.clear();
    notifyListeners();
  }

  Contact? getContact(int index) {
    if (index < 0 || index >= value.length) {
      return null;
    }
    return value[index];
  }
}

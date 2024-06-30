class Contact {
  final String name;

  const Contact({required this.name});
}

class ContactBook {
  ContactBook.sharedInstance();
  static final ContactBook _instance = ContactBook.sharedInstance();
  factory ContactBook() => _instance;

  final List<Contact> _contacts = <Contact>[];

  List<Contact> get contacts => _contacts;

  int get length => _contacts.length;

  void addContact(Contact contact) {
    _contacts.add(contact);
  }
  void removeContact(Contact contact) {
    _contacts.remove(contact);
  }
  void clearContacts() {
    _contacts.clear();
  }
  Contact? getContact(int index) {
    if (index < 0 || index >= _contacts.length) {
      return null;
    }
    return _contacts[index];
  }
}
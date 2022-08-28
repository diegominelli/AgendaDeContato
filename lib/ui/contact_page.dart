import 'package:agenda_de_contato/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  // ignore: use_key_in_widget_constructors
  const ContactPage({this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // ignore: unused_field
  Contact _editContact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editContact = Contact();
    } else {
      _editContact = Contact.fromMap(widget.contact.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editContact.name ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.red,
        child: Icon(Icons.save),
      ),
    );
  }
}

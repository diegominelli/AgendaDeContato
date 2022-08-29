// import 'dart:io';

import 'package:agenda_de_contato/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContactPage extends StatefulWidget {
  final Contact contact;

  // ignore: use_key_in_widget_constructors
  const ContactPage({this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  // ignore: prefer_final_fields, unused_field
  bool _userEdited = false;
  // ignore: unused_field
  Contact _editedContact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.red,
        child: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // image: DecorationImage(
                  //   image: _editedContact.img != null
                  //       ? FileImage(File(_editedContact.img))
                  //       : const AssetImage("images/person.png"),
                  // ),
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nome"),
              onChanged: (text) {
                setState(() {
                  _userEdited = true;
                  _editedContact.name = text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'email'),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'phone'),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.phone = text;
              },
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}

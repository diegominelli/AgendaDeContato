import 'package:agenda_de_contato/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();

    Contact c = Contact();
    c.name = "José Resende";
    c.email = "jose.resende@gmail.com";
    c.phone = "11987259685";
    c.img = "imgtest";

    helper.saveContact(c);

    helper.getAllContacts().then((list) {
      // ignore: avoid_print
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

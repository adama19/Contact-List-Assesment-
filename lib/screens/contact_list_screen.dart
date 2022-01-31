import 'package:contactlist/models/contactlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contact = [];

  Future<void> readJsonFile() async {
    final String response =
        await rootBundle.loadString('assets/Contactlist.json');
    final contactData = await json.decode(response);
    print(contactData);

    var list = contactData as List<dynamic>;

    setState(() {
      contact = list.map((e) => Contact.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Old time")),
                  ElevatedButton(onPressed: () {}, child: Text("Time ago"))
                ],
              ),
            ),
          ),
          if (contact.length > 0)
            Expanded(
              child: ListView.builder(
                itemCount: contact.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(contact[index].name),
                      ),
                    ),
                  );
                },
              ),
            )
          else
            Expanded(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(100),
                child: Text(
                  "No contact found",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
        ],
      ),
    );
  }
}

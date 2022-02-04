import 'package:contactlist/models/contactList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:share/share.dart';

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

    var list = contactData as List<dynamic>;

    setState(() {
      contact = list.map((e) => Contact.fromJson(e)).toList();
    });
  }

  Future<void> _loadData() async {
    return Future.delayed(
      Duration(seconds: 1),
    );
  }

  daysAgo() {
    for (int i = 0; i < contact.length; i++) {
      DateTime now = DateTime.now();
      DateTime checkin = DateTime.parse(contact[i].date);

      Duration indays = now.difference(checkin);

      var res = indays.inDays;
      print("$res days ago");
    }
  }

  @override
  Widget build(BuildContext context) {
    readJsonFile();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: readJsonFile, child: Text("Old time")),
                    ElevatedButton(onPressed: daysAgo, child: Text("Time ago"))
                  ],
                ),
              ),
            ),
            if (contact.length > 0)
              Expanded(
                child: ListView.builder(
                  itemCount: contact.length,
                  itemBuilder: (BuildContext context, index) {
                    final item = contact[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://source.unsplash.com/random?sig=$index',
                          ),
                        ),
                        title: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                child: Text(item.name),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                child: Text(item.phone),
                              ),
                            )
                          ],
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                item.date,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {
                              Share.share(
                                  "https://play.google.com/store/app/details?id=com.instrusctivetech.testapp");
                            }),
                        //selected: true,
                      ),
                    );
                  },
                ),
              )
            else
              Expanded(
                child: Container(
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
      ),
    );
  }
}

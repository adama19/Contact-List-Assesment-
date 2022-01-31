import 'package:contactlist/screens/contact_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact List"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: ContactListScreen(),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: Icon(Icons.arrow_upward))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';

class ContactsSyncingPage extends StatefulWidget {
  @override
  _ContactsSyncingPageState createState() => _ContactsSyncingPageState();
}

class _ContactsSyncingPageState extends State<ContactsSyncingPage> {
  bool connectContacts = true;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Contacts Syncing',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: _size.width,
        height: _size.height,
        padding: EdgeInsets.only(top: 10.0, right: 8.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Connect Contacts',
                style: TextStyle(fontSize: 16.0),
              ),
              trailing: Switch(
                activeColor: Colors.blue,
                value: connectContacts,
                onChanged: (value) {
                  setState(() {
                    connectContacts = value;
                  });
                },
              ),
            ),
            RichText(
              text: TextSpan(
                  text:
                      'To help people connect on Instagram, your contacts are periodically synced and stored on our servers. You choose which ones to follow. ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                  children: [
                    TextSpan(
                      text: 'Learn More',
                      style: TextStyle(color: Colors.blue, fontSize: 12.0),
                    ),
                    TextSpan(text: '.', style: TextStyle(color: Colors.grey))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

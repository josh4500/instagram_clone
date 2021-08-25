import 'package:flutter/material.dart';

class CaptionsPage extends StatefulWidget {
  @override
  _CaptionsPageState createState() => _CaptionsPageState();
}

class _CaptionsPageState extends State<CaptionsPage> {
  bool caption = true;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Cellular Data Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: _size.width,
        height: _size.height,
        padding: EdgeInsets.only(top: 5.0, right: 16.0, left: 16.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Captions',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: Switch(
                activeColor: Colors.blue,
                value: caption,
                onChanged: (value) {
                  setState(() {
                    caption = value;
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Language',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: Text(
                'Énglish (auto-generated)',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

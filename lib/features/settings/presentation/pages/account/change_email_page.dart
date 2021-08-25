import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/sizing.dart';

class ChangeEmailPage extends StatefulWidget {
  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  TextEditingController _editingController;

  @override
  void initState() {
    _editingController = TextEditingController(text: 'amaterasu@gmail.com');
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
          ),
        ),
        elevation: 0.0,
        title: Text(
          'Change email address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.done,
              color: Colors.blue,
              size: 30,
            ),
          ),
          XMargin(10)
        ],
      ),
      body: Container(
        width: _size.width,
        height: _size.height,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            Container(
              width: _size.width,
              child: Row(
                children: [
                  Icon(
                    Icons.mail_outline_sharp,
                    size: 30,
                  ),
                  XMargin(10),
                  Expanded(
                    child: TextField(
                      controller: _editingController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 2.0,
              thickness: 1.0,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}

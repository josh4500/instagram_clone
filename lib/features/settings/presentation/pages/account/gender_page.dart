import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/sizing.dart';
import 'package:instagram_clone/features/authorization/presentation/widgets/custom_radio_button.dart';

enum Gender { female, male, custom, preferNotToSay }

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  var _value = Gender.female;
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
        padding: EdgeInsets.only(top: 30, right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Female',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: CustomRadioButton<Gender>(
                value: Gender.female,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Male',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: CustomRadioButton<Gender>(
                value: Gender.male,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Custom',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: CustomRadioButton<Gender>(
                value: Gender.custom,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
            Visibility(
              visible: _value == Gender.custom,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Custom gender',
                    style: TextStyle(fontSize: 10),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.warning_rounded,
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Prefer not to say',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: CustomRadioButton<Gender>(
                value: Gender.preferNotToSay,
                groupValue: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

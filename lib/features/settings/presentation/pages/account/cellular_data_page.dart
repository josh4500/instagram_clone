import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/sizing.dart';

class CellularDataPage extends StatefulWidget {
  @override
  _CellularDataPageState createState() => _CellularDataPageState();
}

class _CellularDataPageState extends State<CellularDataPage> {
  bool dataSaver = false;

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
        padding: EdgeInsets.only(top: 30.0, right: 8.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use Less Data',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Data Saver',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: Switch(
                activeColor: Colors.blue,
                value: dataSaver,
                onChanged: (value) {
                  setState(() {
                    dataSaver = value;
                  });
                },
              ),
            ),
            Text(
              'When Data Saver is turned on, videos won\'t load in advance to help you use less data.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            YMargin(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'High Resolution Media',
                  style: TextStyle(
                    color: dataSaver ? Colors.white : Colors.grey.shade700,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'Wi-Fi Only',
                  style: TextStyle(
                    color: dataSaver ? Colors.grey : Colors.grey.shade800,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

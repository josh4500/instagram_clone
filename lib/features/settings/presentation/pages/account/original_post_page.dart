import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/sizing.dart';

class OriginalPostPage extends StatefulWidget {
  @override
  _OriginalPostPageState createState() => _OriginalPostPageState();
}

class _OriginalPostPageState extends State<OriginalPostPage> {
  bool saveOringinalPosts = true;

  bool savePostedPhotos = true;

  bool savePostedVideos = true;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Original Posts',
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
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              minVerticalPadding: 0.0,
              leading: Text(
                'Save Original Posts',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: Switch(
                activeColor: Colors.blue,
                value: saveOringinalPosts,
                onChanged: (value) {
                  setState(() {
                    saveOringinalPosts = value;
                  });
                },
              ),
            ),
            YMargin(5),
            Text(
              'Automatically save the unedited photos and videos taken with Instagrams feed camera to your camera roll.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
            YMargin(5),
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Saved Posted Photos',
                style: TextStyle(fontSize: 16.0),
              ),
              trailing: Switch(
                activeColor: Colors.blue,
                value: savePostedPhotos,
                onChanged: (value) {
                  setState(() {
                    savePostedPhotos = value;
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0.0),
              leading: Text(
                'Save Posted Videos',
                style: TextStyle(fontSize: 16.0),
              ),
              trailing: Switch(
                activeColor: Colors.blue,
                value: savePostedVideos,
                onChanged: (value) {
                  setState(() {
                    savePostedVideos = value;
                  });
                },
              ),
            ),
            Text(
              'Saving videos to your phone uses more storage space.',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}

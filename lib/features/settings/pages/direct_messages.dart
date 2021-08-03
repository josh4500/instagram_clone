import 'package:flutter/material.dart';
import 'package:instagram_clone/features/settings/widget/custom_toggle.dart';

class DirectMessages extends StatefulWidget {
  const DirectMessages({Key key}) : super(key: key);

  @override
  _DirectMessagesState createState() => _DirectMessagesState();
}

class _DirectMessagesState extends State<DirectMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direct Messages'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          CustomToggle(
            title: "Message Requests",
            subtitle: "joshual_ wants to send you a message.",
            options: ["Off", "On"],
            selectedIndex: 1,
          ),
          CustomToggle(
            title: "Mesages",
            subtitle: "joshua_l sent you a message.",
            options: ["Off", "On"],
            selectedIndex: 1,
          ),
          CustomToggle(
            title: "Video chats",
            subtitle: "Incoming video chat from joshua_l.",
            options: ["Off", "From People I follow", "From Everyone"],
            selectedIndex: 2,
          ),
        ]),
      ),
    );
  }
}

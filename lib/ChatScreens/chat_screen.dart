import 'package:flutter/material.dart';

import 'chat/messages.dart';
import 'chat/new_message.dart';
import 'package:easy_localization/easy_localization.dart';

class ChatScreen extends StatelessWidget {

  final String chatRoomId;
  final String otherSenderName;
  final String receiverId;
  final String receiverPic;
  ChatScreen(this.chatRoomId,this.otherSenderName,this.receiverId,this.receiverPic);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'inbox'.tr().toString(),
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(chatRoomId),
            ),
            NewMessage(chatRoomId,receiverId),
          ],
        ),
      ),
    );
  }
}

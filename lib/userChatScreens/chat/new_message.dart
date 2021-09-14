
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seniorcare/constant.dart';
import 'package:easy_localization/easy_localization.dart';

class UserNewMessage extends StatefulWidget {
  final DocumentSnapshot userSnapshot;
  final chatRoomID;
  final receiverid;
  UserNewMessage(this.userSnapshot,this.chatRoomID,this.receiverid);
  @override
  _UserNewMessageState createState() => _UserNewMessageState();
}

class _UserNewMessageState extends State<UserNewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('chat').document(widget.chatRoomID).collection('messages').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': widget.userSnapshot.data[USEREMAIL],
      'username': widget.userSnapshot.data[FIRSTNAME]+' '+widget.userSnapshot.data[LASTNAME],
      'receiveruid': 'Admin',
      'userpicurl': widget.userSnapshot.data[USERPICURL]
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey[300],
          offset: Offset(-2, 0),
          blurRadius: 5,
        ),
      ]),
      child: Row(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(left: 15),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText:  'emes'.tr().toString(),
                border: InputBorder.none,
              ),
              onChanged: (value){
                setState(() {
                  _enteredMessage = value;
                });
              },

            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

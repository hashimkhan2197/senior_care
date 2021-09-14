import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class AllChatsScreen extends StatefulWidget {
  @override
  _AllChatsScreenState createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'msgs'.tr().toString(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
//      extendBodyBehindAppBar: true,

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: StreamBuilder(
            stream: Firestore.instance.collection('chat').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final snapShotData = snapshot.data.documents;
              return Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: 130,
                    height: 130,
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (snapshot.data.documents.length == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Center(
                        child: Text('ncy'.tr().toString()),
                      ),
                    ),
                  if (snapshot.data.documents.length > 0)
                    Expanded(
                        child: ListView.separated(
                      itemCount: snapshot.data.documents.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot data = snapShotData[index];
                        String otherSenderName = findOtherSenderName(data);
                        String otherSenderEmail = findOtherSenderEmail(data);
                        String otherSenderUid = findOtherSenderId(data);
                        String otherSenderPic = findOtherPicture(data);
                        return ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChatScreen(
                                  data.documentID,
                                  otherSenderName,
                                  otherSenderUid,
                                  otherSenderPic);
                            }));
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(otherSenderPic),
                            backgroundColor: Colors.white,
                          ),
                          title: Text(
                            otherSenderName,
                            style: TextStyle(fontSize: 15),
                          ),
                          subtitle: Text(
                            otherSenderEmail,
                            maxLines: 1,
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            size: 18,
                          ),
                        );
                      },
                    )),
                ],
              );
            }),
      ),
    );
  }

  String findOtherSenderName(DocumentSnapshot data) {
    List<dynamic> userNames = data.data['usernames'];

    userNames.remove('Admin');
    return userNames[0];
  }

  String findOtherSenderEmail(DocumentSnapshot data) {
    List<dynamic> userEmails = data.data['useremails'];

    userEmails.remove('Admin');
    return userEmails[0];
  }

  String findOtherSenderId(DocumentSnapshot data) {
    List<dynamic> userids = data.data['useruids'];

    userids.remove('Admin');
    return userids[0];
  }

  String findOtherPicture(DocumentSnapshot data) {
    List<dynamic> userPics = data.data['userPics'];

    userPics.remove(
        'https://firebasestorage.googleapis.com/v0/b/senior-service-c083d.appspot.com/o/2021-04-02%2018%3A17%3A57.112460.png?alt=media&token=7a6cb7ef-c472-421f-9ded-635dc71615da');
    return userPics[0];
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Userchat_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class UserAllChatsScreen extends StatefulWidget {
  final String userEmail;
  final String userUid;
  UserAllChatsScreen(this.userEmail,this.userUid);
  @override
  _UserAllChatsScreenState createState() => _UserAllChatsScreenState();
}

class _UserAllChatsScreenState extends State<UserAllChatsScreen> {
  DocumentSnapshot userSnapshot;
  bool _prefloading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _prefloading = true;
      });
      userSnapshot = await Firestore.instance.collection('users').document(widget.userUid).get();
      setState(() {
        _prefloading = false;
      });
    });
    super.initState();
  }

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
        child: _prefloading==true?Center():StreamBuilder(
            stream: Firestore.instance.collection('chat')
                .where('useremails',arrayContains: widget.userEmail).snapshots(),
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
                        child: Text( 'ncy'.tr().toString()),
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
                              return UserChatScreen(userSnapshot,
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

    userNames.remove(userSnapshot.data['name']);
    return userNames[0];
  }

  String findOtherSenderEmail(DocumentSnapshot data) {
    List<dynamic> userEmails = data.data['useremails'];

    userEmails.remove(userSnapshot.data['email']);
    return userEmails[0];
  }
  String findOtherSenderId(DocumentSnapshot data) {
    List<dynamic> userids = data.data['useruids'];

    userids.remove(userSnapshot.data['email']);
    return userids[0];
  }
  String findOtherPicture(DocumentSnapshot data) {
    List<dynamic> userPics = data.data['userPics'];

    userPics.remove(userSnapshot.data['userImage']);
    return userPics[0];
  }
}

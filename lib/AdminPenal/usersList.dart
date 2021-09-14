import 'package:flutter/material.dart';
import 'package:seniorcare/AdminPenal/userProfile.dart';
import 'package:seniorcare/inbox/inbox.dart';
import 'package:seniorcare/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seniorcare/services/chat_service.dart';
import 'package:seniorcare/ChatScreens/chat_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'cgivers'.tr().toString(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection(USERCOLLECTION)
                .where(STATUS, isEqualTo: APPROVED)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
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
                  for (DocumentSnapshot p in snapshot.data.documents)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 8),
                    height: 110,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 0))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 75,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: Image(
                                      image: NetworkImage(p.data[USERPICURL]),
                                      width: 70,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  Text(
                                    p.data[FIRSTNAME]+" " + p.data[LASTNAME],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserProfile(p)));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.lightGreen[500],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    blurRadius: 10,
                                                    offset: Offset(2, 2))
                                              ]),
                                          child: Center(
                                            child: Text(
                                              'details'.tr().toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      InkWell(
                                        onTap: () {  initiateChatConversation(receiverPicture: p.data[USERPICURL],
                                          receiverEmail: p.data[USEREMAIL],
                                          receiverId: p.data[USEREMAIL],
                                          receiverName: p.data[FIRSTNAME]+' '+p.data[LASTNAME],ctx: context,uSnap: p);

                                        },
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[600],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    blurRadius: 10,
                                                    offset: Offset(2, 2))
                                              ]),
                                          child: Center(
                                            child: Text(
                                              'message'.tr().toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => UserProfile()));
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 110,
                  //     decoration: BoxDecoration(
                  //         color: Colors.grey[300],
                  //         borderRadius: BorderRadius.all(Radius.circular(5)),
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: Colors.black.withOpacity(0.1),
                  //               blurRadius: 10,
                  //               offset: Offset(0, 0))
                  //         ]),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Container(
                  //                 width: 90,
                  //                 height: 90,
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.grey[200],
                  //                   borderRadius:
                  //                       BorderRadius.all(Radius.circular(10)),
                  //                 ),
                  //                 child: Center(
                  //                   child: ClipRRect(
                  //                     borderRadius:
                  //                         BorderRadius.all(Radius.circular(10)),
                  //                     child: Image(
                  //                       image: AssetImage('assets/man.jpeg'),
                  //                       width: 80,
                  //                       height: 80,
                  //                       fit: BoxFit.cover,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(width: 40),
                  //               Column(
                  //                 children: [
                  //                   Text(
                  //                     'JOHN DEO',
                  //                     style: TextStyle(
                  //                         fontSize: 18, fontWeight: FontWeight.bold),
                  //                   ),
                  //                   SizedBox(height: 10),
                  //                   Row(
                  //                     mainAxisAlignment: MainAxisAlignment.end,
                  //                     crossAxisAlignment: CrossAxisAlignment.end,
                  //                     children: [
                  //                       InkWell(
                  //                         child: Container(
                  //                           decoration: BoxDecoration(
                  //                             color: Colors.lightGreen[500],
                  //                             borderRadius: BorderRadius.circular(10),
                  //                             boxShadow: [
                  //                               BoxShadow(
                  //                                 color:
                  //                                     Colors.black.withOpacity(0.1),
                  //                                 blurRadius: 5,
                  //                                 offset: Offset(0, 2),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                           padding:
                  //                               EdgeInsets.fromLTRB(30, 8, 30, 8),
                  //                           child: Text(
                  //                             'Message',
                  //                             style: TextStyle(
                  //                                 color: Colors.white, fontSize: 15),
                  //                           ),
                  //                         ),
                  //                         onTap: () {
                  //                           Navigator.push(
                  //                             context,
                  //                             MaterialPageRoute(
                  //                               builder: (context) => Inbox(),
                  //                             ),
                  //                           );
                  //                         },
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            }),
      ),
    );
  }



  /// 1.create a chatroom, send user to the chatroom, other userdetails
  void initiateChatConversation(
      {BuildContext ctx,
        String receiverName,
        receiverEmail,
        receiverId,receiverPicture,uSnap}) async {

      List<String> userNames = ['Admin', receiverName];
      List<String> userEmails = ['Admin', receiverEmail];
      List<String> userUids = ['Admin', receiverId];
      List<String> userPics = ['https://firebasestorage.googleapis.com/v0/b/senior-service-c083d.appspot.com/o/Remove%20BG%201.png?alt=media&token=94bb0cfc-806e-4346-a6fa-ec44d318220e', receiverPicture];

      String chatRoomId =
      ChatService.getChatRoomId('Admin', receiverId);

      Map<String, dynamic> chatRoom = {
        "usernames": userNames,
        'useremails': userEmails,
        'useruids': userUids,
        'userPics':userPics,
        "chatRoomId": chatRoomId,
      };

      await ChatService.addChatRoom(chatRoom, chatRoomId);

      Navigator.push(
          ctx,
          MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(chatRoomId, receiverName, receiverId,receiverPicture)));


  }
}

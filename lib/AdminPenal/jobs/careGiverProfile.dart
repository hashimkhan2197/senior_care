import 'package:flutter/material.dart';
import 'package:seniorcare/inbox/inbox.dart';
import 'package:seniorcare/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:seniorcare/ChatScreens/chat_screen.dart';
import 'package:seniorcare/services/chat_service.dart';
import 'package:easy_localization/easy_localization.dart';


class CareGiverProfile extends StatefulWidget {
  final DocumentSnapshot userSnapshot;
  CareGiverProfile(this.userSnapshot);
  @override
  _CareGiverProfileState createState() => _CareGiverProfileState();
}

class _CareGiverProfileState extends State<CareGiverProfile> {
  Widget _day(String day, bool c) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.lightGreen[500]),
          color: c == true ? Colors.lightGreen[500] : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(2, 2))
          ]),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: c == true ? Colors.white : Colors.black),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'cdet'.tr().toString(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Column(
              children: [
                Container(
                  width: 110,
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            blurRadius: 10,
                            offset: Offset(5, 5))
                      ]),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image(
                        image:
                        NetworkImage(widget.userSnapshot.data[CAREGIVER][USERPICURL]),
                        width: 110,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.userSnapshot.data[CAREGIVER][FIRSTNAME] +
                      ' ' +
                      widget.userSnapshot.data[CAREGIVER][LASTNAME],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  widget.userSnapshot.data[CAREGIVER][USEREMAIL],
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.lightGreen[500],
                  textColor: Colors.white,
                  child: Text( 'message'.tr().toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                      )),
                  onPressed: () {
                   initiateChatConversation(receiverPicture: widget.userSnapshot.data[CAREGIVER][USERPICURL],
                   receiverEmail: widget.userSnapshot.data[CAREGIVER][USEREMAIL],
                   receiverId: widget.userSnapshot.data[CAREGIVER][USEREMAIL],
                   receiverName: widget.userSnapshot.data[CAREGIVER][FIRSTNAME]+' '+widget.userSnapshot.data[CAREGIVER][LASTNAME],ctx: context,);
                  },
                ),
                SizedBox(height: 25),
                ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    'cph'.tr().toString()+'           ',
                    style: TextStyle(fontSize: 14),
                  ),
                  title: Text(
                    widget.userSnapshot.data[CAREGIVER][PHONENUMBER],
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    'cadd'.tr().toString()+'        ',
                    style: TextStyle(fontSize: 14),
                  ),
                  title: Text(
                    widget.userSnapshot.data[CAREGIVER][USERADDRESS],
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    'czc'.tr().toString()+'      ',
                    style: TextStyle(fontSize: 14),
                  ),
                  title: Text(
                    widget.userSnapshot.data[CAREGIVER][USERZIPCODE],
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    'cavai'.tr().toString()+'   ',
                    style: TextStyle(fontSize: 14),
                  ),
                  title: Text(
                    widget.userSnapshot.data[CAREGIVER][USERAVAILABILITY],
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisCount: 7,
                    crossAxisSpacing: 5,
                    children: [
                      _day('S', widget.userSnapshot.data[CAREGIVER][SUNDAY]),
                      _day('M', widget.userSnapshot.data[CAREGIVER][MONDAY]),
                      _day('T', widget.userSnapshot.data[CAREGIVER][TUESDAY]),
                      _day('W', widget.userSnapshot.data[CAREGIVER][WEDNESDAY]),
                      _day('T', widget.userSnapshot.data[CAREGIVER][THURSDAY]),
                      _day('F', widget.userSnapshot.data[CAREGIVER][FRIDAY]),
                      _day('S', widget.userSnapshot.data[CAREGIVER][SATURDAY]),
                    ],
                  ),
                ),

                Divider(),

                ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    'ccerti'.tr().toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                  title: Text(
                    widget.userSnapshot.data[CAREGIVER][USERCERTIFICATIONS],
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    'cexp'.tr().toString()+'    ',
                    style: TextStyle(fontSize: 14),
                  ),
                  title: Text(
                    widget.userSnapshot.data[CAREGIVER][USEREXPERIENCE],
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Divider(),
                ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    'coth'.tr().toString()+'           ',
                    style: TextStyle(fontSize: 14),
                  ),
                  title: Text(
                    widget.userSnapshot.data[CAREGIVER][USEROTHERS],
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  void initiateChatConversation(
      {BuildContext ctx,
        String receiverName,
        receiverEmail,
        receiverId,receiverPicture}) async {

    if(widget.userSnapshot.data['email']!= receiverEmail){

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

    }else{
      showDialog(
          context: context,
          builder: (context){
            return  AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  new BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: Colors.red[400],
                  )),
              title: Text("Chat"),
              content:
              Text('Ycu'.tr().toString()),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.red[400]),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
          );

    }

  }


}

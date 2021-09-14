import 'package:flutter/material.dart';
import 'package:seniorcare/inbox/inbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seniorcare/constant.dart';
import 'package:easy_localization/easy_localization.dart';

class UserProfile extends StatefulWidget {
  final DocumentSnapshot userSnapshot;
  UserProfile(this.userSnapshot);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final _scacffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scacffoldKey,
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
                  height: 150,
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
                        image: NetworkImage(widget.userSnapshot.data[USERPICURL]),
                        width: 110,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  widget.userSnapshot.data[FIRSTNAME]+' ' + widget.userSnapshot.data[LASTNAME],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  widget.userSnapshot.data[USEREMAIL],
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 20),
                ListTile(
                  dense: true,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Text(
                    'cph'.tr().toString()+'           ',
                    style: TextStyle(fontSize: 14),
                  ),
                  title: Text(
                    widget.userSnapshot.data[PHONENUMBER],
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
                    widget.userSnapshot.data[USERADDRESS],
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
                    widget.userSnapshot.data[USERZIPCODE],
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
                    widget.userSnapshot.data[USERAVAILABILITY],
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisCount: 7,
                    crossAxisSpacing: 5,
                    children: [
                      _day('S', widget.userSnapshot.data[SUNDAY]),
                      _day('M', widget.userSnapshot.data[MONDAY]),
                      _day('T', widget.userSnapshot.data[TUESDAY]),
                      _day('W', widget.userSnapshot.data[WEDNESDAY]),
                      _day('T', widget.userSnapshot.data[THURSDAY]),
                      _day('F', widget.userSnapshot.data[FRIDAY]),
                      _day('S', widget.userSnapshot.data[SATURDAY]),
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
                    widget.userSnapshot.data[USERCERTIFICATIONS],
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
                    widget.userSnapshot.data[USEREXPERIENCE],
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
                    widget.userSnapshot.data[USEROTHERS],
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder:(context){
                              return  AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(
                                        18.0),
                                    side: BorderSide(
                                      color: Colors.red[400],
                                    )),
                                title: Text('delcg'.tr().toString()),
                                content: Text(
                                    'ays'.tr().toString()),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      'yes'.tr().toString(),
                                      style: TextStyle(
                                          color: Colors.red[400]),
                                    ),
                                    onPressed: () {
                                      Firestore.instance
                                          .collection(USERCOLLECTION)
                                          .document(widget.userSnapshot.documentID)
                                          .updateData({
                                        STATUS : REJECTED
                                      });
                                      Navigator.pop(context);
                                      Navigator.of(context, rootNavigator: true).pop();

                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'no'.tr().toString(),
                                      style: TextStyle(
                                          color: Colors.black87),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true).pop();
//                                    Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(
                            0, 10, 0, 10),
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.lightGreen[500],
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(2, 2))
                            ]),
                        child: Center(
                          child: Text(
                            'del'.tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(
                            0, 10, 0, 10),
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(2, 2))
                            ]),
                        child: Center(
                          child: Text(
                            'back'.tr().toString(),
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
                SizedBox(height: 25,)

              ],
            ),
          ],
        ),
      ),
    );
  }


}

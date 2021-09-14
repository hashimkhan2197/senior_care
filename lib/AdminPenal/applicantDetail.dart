import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seniorcare/constant.dart';
import 'package:easy_localization/easy_localization.dart';


class ApplicantDetail extends StatefulWidget {
  final DocumentSnapshot userSnapshot;
  ApplicantDetail(this.userSnapshot);
  @override
  _ApplicantDetailState createState() => _ApplicantDetailState();
}

class _ApplicantDetailState extends State<ApplicantDetail> {

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

  bool _isLoading = false;
  final _scacffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scacffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'adet'.tr().toString(),
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
                SizedBox(height: 20),
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
                SizedBox(height: 30),
                _isLoading == true? Center(child: CircularProgressIndicator(),):
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                       onTap: () {
                         setState(() {
                           _isLoading = true;
                         });
                         Firestore.instance
                             .collection(USERCOLLECTION)
                             .document(widget.userSnapshot.documentID)
                             .updateData({
                           STATUS : APPROVED
                         }).then((value) {
                           setState(() {
                             _isLoading = false;
                           });
                           _scacffoldKey.currentState.showSnackBar(SnackBar(
                             content: Text(
                                 'aapprove'.tr().toString(),
                             ),
                             backgroundColor: Colors.green,
                           ));
                         }).catchError((e) {
                           setState(() {
                             _isLoading = false;
                           });
                           print(e);
                           _scacffoldKey.currentState.showSnackBar(SnackBar(
                             content: Text(
                               'errtl'.tr().toString(),
                             ),
                             backgroundColor: Theme.of(context).errorColor,
                           ));
                         });
                       },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        width: MediaQuery.of(context).size.width / 2.25,
                        decoration: BoxDecoration(
                            color: Colors.lightGreen[500],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(2, 2))
                            ]),
                        child: Center(
                          child: Text(
                              'aapprovea'.tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isLoading = true;
                        });
                        Firestore.instance
                            .collection(USERCOLLECTION)
                            .document(widget.userSnapshot.documentID)
                            .updateData({
                          STATUS : REJECTED
                        }).then((value) {
                          setState(() {
                            _isLoading = false;
                          });
                          _scacffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'arejected'.tr().toString(),
                            ),
                            backgroundColor: Theme.of(context).errorColor,
                          ));
                        }).catchError((e) {
                          setState(() {
                            _isLoading = false;
                          });
                          print(e);
                          _scacffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'errtl'.tr().toString(),
                            ),
                            backgroundColor: Theme.of(context).errorColor,
                          ));
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        width: MediaQuery.of(context).size.width / 2.25,
                        decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(2, 2))
                            ]),
                        child: Center(
                          child: Text(
                              'rejecta'.tr().toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,)
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.edit,
      //     color: Colors.grey[600],
      //   ),
      //   backgroundColor: Colors.grey[200],
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => EditProfile()));
      //   },
      // ),
    );
  }
}

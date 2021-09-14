import 'package:flutter/material.dart';
import 'package:seniorcare/menu/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seniorcare/constant.dart';
import 'package:easy_localization/easy_localization.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _prefloading = false;
  String currentUserId;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _prefloading = true;
      });
      FirebaseUser authResult = await FirebaseAuth.instance.currentUser();
      setState(() {
        currentUserId = authResult.uid;
        _prefloading = false;
        print(currentUserId);
      });
    });
    super.initState();
  }

  ///BUILD START HERE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'profile'.tr().toString(),
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
        child: _prefloading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder(
                stream: Firestore.instance
                    .collection(USERCOLLECTION)
                    .document(currentUserId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
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
                                  image: NetworkImage(snapshot.data[USERPICURL]),
                                  width: 110,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            snapshot.data[FIRSTNAME] +
                                ' ' +
                                snapshot.data[LASTNAME],
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          Text(
                            snapshot.data[USEREMAIL],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 20),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: [
//                        Container(
//                          height: 80,
//                          width: 120,
//                          decoration: BoxDecoration(
//                              color: Colors.grey[100],
//                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                              boxShadow: [
//                                BoxShadow(
//                                    color: Colors.black.withOpacity(0.2),
//                                    blurRadius: 10,
//                                    offset: Offset(2, 2))
//                              ]),
//                          child: Center(
//                            child: Column(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: [
//                                Text(
//                                  '\$100',
//                                  style: TextStyle(
//                                      fontSize: 20, fontWeight: FontWeight.bold),
//                                ),
//                                SizedBox(height: 5),
//                                Text(
//                                  'Net worth',
//                                  style: TextStyle(fontWeight: FontWeight.w300),
//                                )
//                              ],
//                            ),
//                          ),
//                        ),
//                        Container(
//                          height: 80,
//                          width: 120,
//                          decoration: BoxDecoration(
//                              color: Colors.grey[100],
//                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                              boxShadow: [
//                                BoxShadow(
//                                    color: Colors.black.withOpacity(0.2),
//                                    blurRadius: 10,
//                                    offset: Offset(2, 2))
//                              ]),
//                          child: Center(
//                            child: Column(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: [
//                                Text(
//                                  '\$100',
//                                  style: TextStyle(
//                                      fontSize: 20, fontWeight: FontWeight.bold),
//                                ),
//                                SizedBox(height: 5),
//                                Text(
//                                  'Balance',
//                                  style: TextStyle(fontWeight: FontWeight.w300),
//                                )
//                              ],
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: Offset(2, 2))
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ph'.tr().toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data[PHONENUMBER],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'ad'.tr().toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data[USERADDRESS],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'zc2'.tr().toString(),
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data[USERZIPCODE],
                                    style:
                                    TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'av'.tr().toString(),
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data[USERAVAILABILITY],
                                    style:
                                    TextStyle(fontWeight: FontWeight.w300),
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
                                        _day('S', snapshot.data[SUNDAY]),
                                        _day('M', snapshot.data[MONDAY]),
                                        _day('T', snapshot.data[TUESDAY]),
                                        _day('W', snapshot.data[WEDNESDAY]),
                                        _day('T', snapshot.data[THURSDAY]),
                                        _day('F', snapshot.data[FRIDAY]),
                                        _day('S', snapshot.data[SATURDAY]),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 2,),
                                  Text(
                                    'cer'.tr().toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data[USERCERTIFICATIONS],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'exp'.tr().toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data[USEREXPERIENCE],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'oth'.tr().toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data[USEROTHERS],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(height: 30),
                          // ListTile(
                          //   dense: true,
                          //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          //   leading: Text(
                          //     'Phone:     ',
                          //     style: TextStyle(fontSize: 16),
                          //   ),
                          //   title: Text(
                          //     '+923161964761',
                          //     style: TextStyle(color: Colors.grey, fontSize: 16),
                          //   ),
                          // ),
                          // Divider(),
                          // ListTile(
                          //   dense: true,
                          //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          //   leading: Text(
                          //     'Address:   ',
                          //     style: TextStyle(fontSize: 16),
                          //   ),
                          //   title: Text(
                          //     'Description or info of the job. Lorem Ipsum is simply dummy text of the printing and types...',
                          //     style: TextStyle(color: Colors.grey, fontSize: 16),
                          //   ),
                          // ),
                          // Divider(),
                          // ListTile(
                          //   dense: true,
                          //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          //   leading: Text(
                          //     'Certifications:',
                          //     style: TextStyle(fontSize: 12),
                          //   ),
                          //   title: Text(
                          //     'Description or info of the job. Lorem Ipsum is simply dummy text ',
                          //     style: TextStyle(color: Colors.grey, fontSize: 16),
                          //   ),
                          // ),
                          // Divider(),
                          // ListTile(
                          //   dense: true,
                          //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          //   leading: Text(
                          //     'Experience:',
                          //     style: TextStyle(fontSize: 14),
                          //   ),
                          //   title: Text(
                          //     'Description or info of the job. Lorem Ipsum is simply dummy text of the printing and types...',
                          //     style: TextStyle(color: Colors.grey, fontSize: 16),
                          //   ),
                          // ),
                          // Divider(),
                          // ListTile(
                          //   dense: true,
                          //   visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          //   leading: Text(
                          //     'Others:     ',
                          //     style: TextStyle(fontSize: 16),
                          //   ),
                          //   title: Text(
                          //     'Description or info of the job. Lorem Ipsum is simply dummy text of the printing and types...',
                          //     style: TextStyle(color: Colors.grey, fontSize: 16),
                          //   ),
                          // ),
                          SizedBox(height: 20),
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            color: Colors.grey[700],
                            textColor: Colors.white,
                            child: Text( 'eprof'.tr().toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile(snapshot)));
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ],
                  );
                }),
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

}

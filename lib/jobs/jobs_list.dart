import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:seniorcare/LoginSignup/login.dart';
import 'package:seniorcare/aboutus.dart';
import 'package:seniorcare/jobs/job_details.dart';
import 'package:seniorcare/inbox/inbox.dart';
import 'package:seniorcare/menu/profile.dart';
import 'package:seniorcare/AdminPenal/main_page.dart';
import 'package:seniorcare/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seniorcare/LoginSignup/thankyouPage.dart';
import 'package:seniorcare/userChatScreens/all_chats_screen.dart';
class JobsList extends StatefulWidget {
  @override
  _JobsListState createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  bool _prefloading = false;
  String currentUserEmail;
  String currentUserId;
//  DocumentSnapshot userSnapshot;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _prefloading = true;
      });
      FirebaseUser authResult = await FirebaseAuth.instance.currentUser();
//      userSnapshot = await Firestore.instance.collection('users').document(authResult.uid).get();
      setState(() {
        currentUserEmail = authResult.email;
        currentUserId = authResult.uid;
        _prefloading = false;
        print(currentUserEmail);
      });
    });
    super.initState();
  }

  int controller = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _prefloading==true?Scaffold(body: Center(),):currentUserEmail == 'seniorservicestaff@gmail.com' ? MainPage():DefaultTabController(
        length: 3,
        child: StreamBuilder(
          stream: Firestore.instance.collection('users').document(currentUserId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
//                child: CircularProgressIndicator(),
                ),
              );
            }
            if(snapshot.data[STATUS] == PENDING){
              return ThankyouPage();
            }
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                iconTheme: IconThemeData(color: Colors.black),
                //leading: Icon(Icons.notifications, color: Colors.black87,),
                title: Container(
                  width: 120,
                  height: 50,
                  child: Image(
                    image: AssetImage('assets/appbarlogo.png'),
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(90),
                  child: Column(
                    children: [
                      Text(
                        'jlist'.tr().toString(),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 7),
                      TabBar(
                        //indicatorColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.grey[700],
                        indicatorColor: Colors.grey[700],
                        tabs: [
                          Tab(text:  'open'.tr().toString()),
                          Tab(text:  'awarded'.tr().toString()),
                          Tab(text:  'comp'.tr().toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: StreamBuilder(
                stream: Firestore.instance.collection(JOBSCOLLECTION).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return TabBarView(
                    children: [
                      ///Open JOBS
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: ListView(
                          children: [
                            SizedBox(height: 15),
                            for (DocumentSnapshot p in snapshot.data.documents)
                              if (p.data[STATUS] == OPEN)
                                Container(
//                          height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: Offset(2, 2))
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        p.data[JOBTITLE],
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        p.data[JOBDESCRIPTION],
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer_sharp,
                                            color: Colors.lightGreen[500],
                                            size: 15,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            'jhours'.tr().toString(),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            '${p.data[JOBTIMINGFROM]} - ${p.data[JOBTIMINGTO]}',
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Center(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        JobDetails(p,OPEN)));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 15),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                2.25,
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
                                                'view'.tr().toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      ///AWARDED JOBS
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: ListView(
                          children: [
                            SizedBox(height: 15),
                            for (DocumentSnapshot p in snapshot.data.documents)
                              if (p.data[STATUS] == AWARDED && p.data[CAREGIVER][USEREMAIL]== currentUserEmail)
                                Container(
//                            height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: Offset(2, 2))
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        p.data[JOBTITLE],
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        p.data[JOBDESCRIPTION],
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer_sharp,
                                            color: Colors.lightGreen[500],
                                            size: 15,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            'jhours'.tr().toString(),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            '${p.data[JOBTIMINGFROM]} - ${p.data[JOBTIMINGTO]}',
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
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
                                                         JobDetails(p,AWARDED)));
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2.25,
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
                                                  'view'.tr().toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          JobDetails(p,AWARDED)));
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2.25,
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
                                                  'jcomp'.tr().toString(),
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
                                ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      ///Completed JOBS
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: ListView(
                          children: [
                            SizedBox(height: 15),
                            for (DocumentSnapshot p in snapshot.data.documents)
                              if (p.data[STATUS] == COMPLETED && p.data[CAREGIVER][USEREMAIL]== currentUserEmail)
                                Container(
//                          height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: Offset(2, 2))
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        p.data[JOBTITLE],
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        p.data[JOBDESCRIPTION],
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.timer_sharp,
                                            color: Colors.lightGreen[500],
                                            size: 15,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            'jhours'.tr().toString(),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            '${p.data[JOBTIMINGFROM]} - ${p.data[JOBTIMINGTO]}',
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Center(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        JobDetails(p, COMPLETED)));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 15),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                2.25,
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
                                                'view'.tr().toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              ),
              drawer: Drawer(
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: <Widget>[
                    SizedBox(height: 100),
                    Container(
                      width: 120,
                      height: 120,
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                    SizedBox(height: 70),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      leading: Image(
                        image: AssetImage('assets/user.png'),
                        width: 30,
                        height: 30,
                      ),
                      title: Text( 'profile'.tr().toString()),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UserAllChatsScreen(currentUserEmail,currentUserId)));
                      },
                      leading: Image(
                        image: AssetImage('assets/inbox.png'),
                        width: 30,
                        height: 30,
                      ),
                      title: Text( 'inbox'.tr().toString()),
                    ),
                    ListTile(
                      onTap: () {
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context) => AboutUs()));
                      },
                      leading: Image(
                        image: AssetImage('assets/about.jpg'),
                        width: 30,
                        height: 30,
                      ),
                      title: Text( 'aus'.tr().toString()),
                    ),
                    SizedBox(height: 15,),
                    Text('slang'.tr().toString(),textAlign:TextAlign.center,
                      style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 16),)
                 ,
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          textColor: Colors.white,
                          onPressed: () {
                            EasyLocalization.of(context).locale =
                                Locale("en", "US");
                            Navigator.pop(context);

                          },
                          elevation: 3,
                          child: Text(
                            "English",
                          ),
                          color: Colors.blueGrey,
                        ),
SizedBox(width: 10,),
                        RaisedButton(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          textColor: Colors.white,
                          onPressed: () {
                            EasyLocalization.of(context).locale =
                                Locale("es", "ESP");
                            Navigator.pop(context);
                          },
                          elevation: 3,
                          child: Text(
                            "Spanish",
                          ),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                      child: RaisedButton(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        textColor: Colors.white,
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                                return Login();
                              }), (route) => false);

                        },
                        elevation: 3,
                        child: Text(
                          'logout'.tr().toString(),
                        ),
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }


}

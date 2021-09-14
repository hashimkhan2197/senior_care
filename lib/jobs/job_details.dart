import 'package:flutter/material.dart';
import 'package:seniorcare/jobs/jobs_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seniorcare/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seniorcare/show_dialog_widget.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class JobDetails extends StatefulWidget {
  final DocumentSnapshot jopSnapshot;
  final String jobTypeString;

  JobDetails(this.jopSnapshot, this.jobTypeString);

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final _scacffoldKey = GlobalKey<ScaffoldState>();
  bool _prefloading = false;
  String currentUserId;
  bool signupLoading = false;

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

  ///BUILD STARTS HERE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scacffoldKey,
      appBar: AppBar(
        title: Text(
          'jdet'.tr().toString(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
//                child: CircularProgressIndicator(),
                        );
                  }

                  return ListView(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.jopSnapshot.data[JOBTITLE],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.jopSnapshot.data[JOBDESCRIPTION],
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_sharp,
                            color: Colors.lightGreen[500],
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'jh'.tr().toString()+':',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${widget.jopSnapshot.data[JOBTIMINGFROM]} - ${widget.jopSnapshot.data[JOBTIMINGTO]}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.lightGreen[500],
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'sd'.tr().toString()+':',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.jopSnapshot.data[JOBSTARTINGDATE]
                                .toDate()
                                .toString()
                                .split(' ')
                                .first,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.view_day, color: Colors.lightGreen[500]),
                          SizedBox(width: 10),
                          Text(
                            'days'.tr().toString(),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.count(
                          crossAxisCount: 7,
                          crossAxisSpacing: 5,
                          children: [
                            _day('S', widget.jopSnapshot.data[SUNDAY]),
                            _day('M', widget.jopSnapshot.data[MONDAY]),
                            _day('T', widget.jopSnapshot.data[TUESDAY]),
                            _day('W', widget.jopSnapshot.data[WEDNESDAY]),
                            _day('T', widget.jopSnapshot.data[THURSDAY]),
                            _day('F', widget.jopSnapshot.data[FRIDAY]),
                            _day('S', widget.jopSnapshot.data[SATURDAY]),
                          ],
                        ),
                      ),
                      ///PAY DETAILS
                      Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: Colors.lightGreen[500],
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'pd'.tr().toString()+':',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.jopSnapshot.data[PAYDETAIL],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ///NOTES
                      Row(
                        children: [
                          Icon(
                            Icons.home_work,
                            color: Colors.lightGreen[500],
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'notes'.tr().toString()+':',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.jopSnapshot.data[JOBEXPERIENCE],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ///JOB LOCATION
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.lightGreen[500],
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'location'.tr().toString()+':',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.jopSnapshot.data[JOBLOCATION],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ///ZIP CODE
                      Row(
                        children: [
                          Icon(
                            Icons.local_activity,
                            color: Colors.lightGreen[500],
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'zc'.tr().toString()+':',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.jopSnapshot.data[JOBZIPCODE],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () => MapsLauncher.launchQuery(widget.jopSnapshot.data[JOBLOCATION]),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: Container(
                            width: 600,
                            height: 100,
                            child: Image(
                              image: AssetImage('assets/map.jpg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
//                signupLoading
//                    ? Center(child: CircularProgressIndicator()):
                      ///OPEN
                      if (widget.jobTypeString == OPEN)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                submitApplication(snapshot);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                width: MediaQuery.of(context).size.width / 2.25,
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen[500],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: Offset(2, 2))
                                    ]),
                                child: Center(
                                  child: Text(
                                    'appcap'.tr().toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JobsList()));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                width: MediaQuery.of(context).size.width / 2.25,
                                decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: Offset(2, 2))
                                    ]),
                                child: Center(
                                  child: Text(
                  'back'.tr().toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ///AWARDED
                      if (widget.jobTypeString == AWARDED)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                jobCompleted();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                width: MediaQuery.of(context).size.width / 2.25,
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen[500],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: Offset(2, 2))
                                    ]),
                                child: Center(
                                  child: Text(
                                    'jcomp'.tr().toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JobsList()));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                width: MediaQuery.of(context).size.width / 2.25,
                                decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: Offset(2, 2))
                                    ]),
                                child: Center(
                                  child: Text(
                  'back'.tr().toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ///COMPLETED
                      if (widget.jobTypeString == COMPLETED)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JobsList()));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                width: MediaQuery.of(context).size.width / 2.25,
                                decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: Offset(2, 2))
                                    ]),
                                child: Center(
                                  child: Text(
                  'back'.tr().toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                }),
      ),
    );
  }

  ///function to add user data to a firebase collection
  Future<void> submitApplication(AsyncSnapshot s) async {
//    setState(() {
//      signupLoading=true;
//    });
    await Firestore.instance
        .collection(JOBSCOLLECTION)
        .document(widget.jopSnapshot.documentID)
        .collection(APPLICANTSCOLLECTION)
        .document(s.data.documentID)
        .setData({
      USERPICURL: s.data[USERPICURL],
      FIRSTNAME: s.data[FIRSTNAME],
      LASTNAME: s.data[LASTNAME],
      USEREMAIL: s.data[USEREMAIL],
      PHONENUMBER: s.data[PHONENUMBER],
      USERADDRESS: s.data[USERADDRESS],
      USERCERTIFICATIONS: s.data[USERCERTIFICATIONS],
      USEREXPERIENCE: s.data[USEREXPERIENCE],
      USEROTHERS: s.data[USEROTHERS],
      USERZIPCODE: s.data[USERZIPCODE],
      USERAVAILABILITY: s.data[USERAVAILABILITY],
      MONDAY : s.data[MONDAY],
      TUESDAY : s.data[TUESDAY],
      WEDNESDAY : s.data[WEDNESDAY],
      THURSDAY : s.data[THURSDAY],
      FRIDAY : s.data[FRIDAY],
      SATURDAY : s.data[SATURDAY],
      SUNDAY : s.data[SUNDAY],
      SIGNUPDATE: DateTime.now(),
    }).then((value) {
//      setState(() {
//        signupLoading = false;
//      });
      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
            'asubmit'.tr().toString(),
        ),
        backgroundColor: Colors.lightGreen,
      ));
    }).catchError((e) {
//      setState(() {
//        signupLoading = false;
//      });
      print(e);
      showDialog(
          context: context,
          builder:(context){return ShowDialogWidget(
            borderColor: Colors.red[400],
            titleText:  'err'.tr().toString(),
            subText: 'etl'.tr().toString()
            ,
          );} );
    });
  }

  Future<void> jobCompleted() async {
//    setState(() {
//      signupLoading=true;
//    });
    await Firestore.instance
        .collection(JOBSCOLLECTION)
        .document(widget.jopSnapshot.documentID)
        .updateData({
      STATUS: COMPLETED,
      JOBCOMPLETEDATE: DateTime.now(),
    }).then((value) {
      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          'jsu'.tr().toString(),
        ),
        backgroundColor: Colors.lightGreen,
      ));
    }).catchError((e) {
//      setState(() {
//        signupLoading = false;
//      });
      print(e);

      showDialog(
          context: context,
          builder:(context){return  ShowDialogWidget(
            borderColor: Colors.red[400],
            titleText:  'err'.tr().toString(),
            subText:
            'etl'.tr().toString(),
          );});
    });
  }
}

Widget _day(String day, bool c) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.lightGreen[500]),
        color: c == true ? Colors.lightGreen[500] : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: Colors.grey.withOpacity(0.2),
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

import 'package:flutter/material.dart';
import 'package:seniorcare/AdminPenal/jobs/jobApplicants.dart';
import 'package:seniorcare/jobs/jobs_list.dart';
import 'package:seniorcare/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:seniorcare/show_dialog_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminOpenJobDetails extends StatefulWidget {
  final DocumentSnapshot jopSnapshot;

  AdminOpenJobDetails(this.jopSnapshot);

  @override
  _AdminOpenJobDetailsState createState() => _AdminOpenJobDetailsState();
}

class _AdminOpenJobDetailsState extends State<AdminOpenJobDetails> {
  final _scacffoldKey = GlobalKey<ScaffoldState>();
  bool jobcancelled = false;
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
        child: ListView(
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  widget.jopSnapshot.data[JOBSTARTINGDATE].toDate().toString().split(' ').first,
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
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                  _day('S',widget.jopSnapshot.data[SUNDAY]),
                  _day('M',widget.jopSnapshot.data[MONDAY]),
                  _day('T',widget.jopSnapshot.data[TUESDAY]),
                  _day('W',widget.jopSnapshot.data[WEDNESDAY]),
                  _day('T',widget.jopSnapshot.data[THURSDAY]),
                  _day('F',widget.jopSnapshot.data[FRIDAY]),
                  _day('S',widget.jopSnapshot.data[SATURDAY]),
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
            if(jobcancelled == false)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobApplicants(widget.jopSnapshot)));
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
                        'applicants'.tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    jobCancelled();
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
                        'cjob'.tr().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
  Future<void> jobCancelled() async {
//    setState(() {
//      signupLoading=true;
//    });
    await Firestore.instance
        .collection(JOBSCOLLECTION)
        .document(widget.jopSnapshot.documentID)
        .delete().then((value) {
          setState(() {
            jobcancelled = true;
          });
      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          'jcancel'.tr().toString(),
        ),
        backgroundColor: Colors.red,
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
            titleText: 'err'.tr().toString(),
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
        color: c==true?Colors.lightGreen[500]:Colors.white,
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
            fontSize: 17, fontWeight: FontWeight.bold, color: c==true?Colors.white:Colors.black),
      ),
    ),
  );
}

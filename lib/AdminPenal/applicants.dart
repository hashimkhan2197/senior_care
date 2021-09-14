import 'package:flutter/material.dart';
import 'package:seniorcare/AdminPenal/applicantDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seniorcare/constant.dart';
import 'package:easy_localization/easy_localization.dart';


class Applicants extends StatefulWidget {
  @override
  _ApplicantsState createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'alist'.tr().toString(),
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
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: StreamBuilder(
          stream: Firestore.instance.collection(USERCOLLECTION).where(STATUS,isEqualTo: PENDING).snapshots(),
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
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicantDetail(p),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(p.data[USERPICURL]),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    p.data[FIRSTNAME]+" " + p.data[LASTNAME],
                    style: TextStyle(fontSize: 15),
                  ),
                  subtitle: Text(p.data[SIGNUPDATE].toDate().toString().split(' ').first),
                  trailing: Icon(
                    Icons.navigate_next,
                    size: 18,
                  ),
                ),
                for (DocumentSnapshot p in snapshot.data.documents)
                  Divider()

              ],
            );
          }
        ),
      ),
    );
  }
}

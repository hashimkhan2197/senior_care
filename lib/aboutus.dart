import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seniorcare/LoginSignup/login.dart';
import 'package:easy_localization/easy_localization.dart';


class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [
            SizedBox(height: 20),
//            SizedBox(height: 20),
            Container(
              width: 140,
              height: 140,
              child: Image(
                image: AssetImage('assets/logo.png'),
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Senior Care Services Inc.",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "6356 Manor Lane Suite 103",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Miami, Florida 33143",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 8),
            Text(
              "(305) 271-7065",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 8),
            Text(
              "info@seniorcareservicesmiami.com",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),

          ],
        ),
      ),
    );
  }
}


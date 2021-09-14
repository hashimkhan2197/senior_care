import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seniorcare/LoginSignup/login.dart';
import 'package:easy_localization/easy_localization.dart';


class ThankyouPage extends StatefulWidget {
  @override
  _ThankyouPageState createState() => _ThankyouPageState();
}

class _ThankyouPageState extends State<ThankyouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(height: 20),
            Container(
              width: 170,
              height: 170,
              child: Image(
                image: AssetImage('assets/logo.png'),
              ),
            ),
            SizedBox(height: 70),
            Text(
              'thank'.tr().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              'rev'.tr().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              'notify'.tr().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 25, 60, 5),
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
}


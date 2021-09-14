import 'package:flutter/material.dart';
import 'package:seniorcare/AdminPenal/jobs/adminJobslist.dart';
import 'package:seniorcare/AdminPenal/applicants.dart';
import 'package:seniorcare/AdminPenal/usersList.dart';
import 'package:seniorcare/inbox/messages.dart';
import 'package:seniorcare/ChatScreens/all_chats_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seniorcare/LoginSignup/login.dart';
import 'package:easy_localization/easy_localization.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ap'.tr().toString(),
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
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Container(
              width: 150,
              height: 150,
              child: Image(
                image: AssetImage('assets/logo.png'),
              ),
            ),
            SizedBox(height: 60),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Applicants(),
                  ),
                );
              },
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              leading: Icon(
                Icons.person_add,
                color: Colors.grey,
              ),
              title: Text(
                'ca'.tr().toString(),
                style: TextStyle(fontSize: 17),
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 18,
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsersList(),
                  ),
                );
              },
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              leading: Icon(
                Icons.people,
                color: Colors.grey,
              ),
              title: Text(
                'ac'.tr().toString(),
                style: TextStyle(fontSize: 17),
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 18,
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminJobsList(),
                  ),
                );
              },
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              leading: Icon(
                Icons.work,
                color: Colors.grey,
              ),
              title: Text(
                'lj'.tr().toString(),
                style: TextStyle(fontSize: 17),
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 18,
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllChatsScreen(),
                  ),
                );
              },
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              leading: Icon(
                Icons.message,
                color: Colors.grey,
              ),
              title: Text(
                'inbox'.tr().toString(),
                style: TextStyle(fontSize: 17),
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 18,
              ),
            ),
            Divider(),

            Padding(
              padding: const EdgeInsets.fromLTRB(60, 15, 60, 5),
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


import 'package:flutter/material.dart';
import 'package:seniorcare/inbox/inbox.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
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
        child: ListView(
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
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Inbox(),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/man.jpeg'),
                backgroundColor: Colors.white,
              ),
              title: Text(
                'John deo',
                style: TextStyle(fontSize: 15),
              ),
              subtitle: Text('I want this job can i have it?',
              maxLines: 1,),
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
                    builder: (context) => Inbox(),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/man.jpeg'),
                backgroundColor: Colors.white,
              ),
              title: Text(
                'John deo',
                style: TextStyle(fontSize: 15),
              ),
              subtitle: Text('I want this job can i have it?',
              maxLines: 1,),
              trailing: Icon(
                Icons.navigate_next,
                size: 18,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

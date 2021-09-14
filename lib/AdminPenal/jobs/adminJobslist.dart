import 'package:flutter/material.dart';
import 'package:seniorcare/AdminPenal/jobs/addNewJob.dart';
import 'package:seniorcare/AdminPenal/jobs/adminAwardedJobDetail.dart';
import 'package:seniorcare/AdminPenal/jobs/adminOpenJobDetail.dart';
import 'package:seniorcare/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminJobsList extends StatefulWidget {
  @override
  _AdminJobsListState createState() => _AdminJobsListState();
}

class _AdminJobsListState extends State<AdminJobsList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
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
                      Tab(text: 'open'.tr().toString()),
                      Tab(text: 'awarded'.tr().toString()),
                      Tab(text: 'comp'.tr().toString()),
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
                                                      AdminOpenJobDetails(p)));
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
                            if (p.data[STATUS] == AWARDED)
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
                                                        AdminAwardedJobDetails(p)));
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
                                                        AdminAwardedJobDetails(p)));
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

                    ///COMPLETED JOBS
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: ListView(
                        children: [
                          SizedBox(height: 15),
                          for (DocumentSnapshot p in snapshot.data.documents)
                            if (p.data[STATUS] == COMPLETED)
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
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminAwardedJobDetails(p)));
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
              }),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightGreen[500],
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNewJob()));
            },
          ),
        ),
      ),
    );
  }
}

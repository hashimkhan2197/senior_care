import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seniorcare/constant.dart';
import 'package:easy_localization/easy_localization.dart';

class AddNewJob extends StatefulWidget {
  @override
  _AddNewJobState createState() => _AddNewJobState();
}

class _AddNewJobState extends State<AddNewJob> {

  ///variables
  var _isLoading = false;
  final _scacffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  ///Text Editing Controllers
  TextEditingController titleController = TextEditingController(text:'');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController paydetailController = TextEditingController(text: '');
  TextEditingController experienceController = TextEditingController(text: '');
  TextEditingController locationController = TextEditingController(text: '');
  TextEditingController zipController = TextEditingController(text: '');

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    paydetailController.dispose();
    paydetailController.dispose();
    locationController.dispose();
    zipController.dispose();
    super.dispose();
  }


  TimeOfDay timeFrom;
  TimeOfDay timeTo;
  TimeOfDay picked;

  @override
  void initState() {
    super.initState();
    timeFrom = TimeOfDay.now();
    timeTo = TimeOfDay.now();
  }

  Future<Null> selectTimeFrom(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: timeFrom);

    if (picked != null) {
      setState(() {
        timeFrom = picked;
      });
    }
  }
  Future<Null> selectTimeTo(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: timeTo);

    if (picked != null) {
      setState(() {
        timeTo = picked;
      });
    }
  }

//  DateTime _dateTime;
  DateTime selectedDate = DateTime.now();

  bool sunday = true;
  bool monday = true;
  bool tuesday = true;
  bool wednesday = true;
  bool thursday = true;
  bool friday = true;
  bool saturday = true;

  _selectstartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      helpText: 'dosj'.tr().toString(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scacffoldKey,
      appBar: AppBar(
        title: Text(
          'pnj'.tr().toString(),
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
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formKey,
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
              Text(
                'title'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _input(
                  'title'.tr().toString(),titleController
              ),
              SizedBox(height: 15),
              Text(
                'desc'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _descriptioninput(
                  'td'.tr().toString(),descriptionController
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'jh'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'from'.tr().toString()+'  ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.lightGreen[500]))),
                    child: InkWell(
                        child: Text(
                          '${timeFrom.format(context)}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen[500]),
                        ),
                        onTap: () {
                          selectTimeFrom(context);
                          print(timeFrom);
                        }),
                  ),
                  Text(
                    'to'.tr().toString()+'  ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.lightGreen[500]))),
                    child: InkWell(
                        child: Text(
                          '${timeTo.format(context)}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen[500]),
                        ),
                        onTap: () {
                          selectTimeTo(context);
                          print(timeTo);
                        }),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'sd'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectstartDate(context), // Refer step 3
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        color: Colors.lightGreen[500],
                      )),
                    ),
                    child: Center(
                      child: Text(
                        'sjsd'.tr().toString(),
                        style: TextStyle(
                          color: Colors.lightGreen[500],
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'sdays'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  crossAxisCount: 7,
                  crossAxisSpacing: 5,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          sunday = !sunday;
                        });
                      },
                      child: sunday
                          ? _unselectedday('S')
                          : _selectedday('S')
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          monday = !monday;
                        });
                      },
                      child: monday
                          ? _unselectedday('M')
                          : _selectedday('M')
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          tuesday = !tuesday;
                        });
                      },
                      child: tuesday
                          ? _unselectedday('T')
                          : _selectedday('T')
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          wednesday= !wednesday;
                        });
                      },
                      child: wednesday
                          ? _unselectedday('W')
                          : _selectedday('W')
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          thursday = !thursday;
                        });
                      },
                      child: thursday
                          ? _unselectedday('T')
                          : _selectedday('T')
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          friday = !friday;
                        });
                      },
                      child: friday
                          ? _unselectedday('F')
                          : _selectedday('F')
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          saturday = !saturday;
                        });
                      },
                      child: saturday
                          ? _unselectedday('S')
                          : _selectedday('S')
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text(
                'pd'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _input(
                  'pd'.tr().toString(),paydetailController
              ),
              SizedBox(height: 15),
              Text(
                'notes'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _descriptioninput(
                  'notes'.tr().toString(),experienceController
              ),
              SizedBox(height: 15),
              Text(
                'location'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _descriptioninput(
                  'location'.tr().toString(),locationController
              ),
              SizedBox(height: 15),
              Text(
                'zc'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _input(
                  'zc'.tr().toString(),zipController
              ),

              SizedBox(height: 25),
              _isLoading==true?Center(child:
              CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF166138))),)
                  :Padding(
                  padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.lightGreen[500],
                  textColor: Colors.white,
                  child: Text('post'.tr().toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                      )),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      //Only gets here if the fields pass
                      _formKey.currentState.save();
                      _addPetition(titleController.text, descriptionController.text, context);
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }


  Widget _input(String hint,TextEditingController controller,{bool optional=false}) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(2, 2))
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 15, 0),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value.isEmpty && optional == false) {
              return 'empty'.tr().toString();
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
              //labelText: label,
              hintText: hint,
              focusColor: Colors.grey,

              //fillColor: Colors.white,

              fillColor: Colors.white),
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }

  Widget _descriptioninput(String hint,TextEditingController controller,{bool optional=false}) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(2, 2))
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 15, 0),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value.isEmpty && optional == false) {
              return 'empty'.tr().toString();
            }
            return null;
          },
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
              //labelText: label,
              hintText: hint,
              focusColor: Colors.grey,

              //fillColor: Colors.white,

              fillColor: Colors.white),
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }


  Widget _unselectedday(String day) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.lightGreen[500]),
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
            fontSize: 17, fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }

  Widget _selectedday(String day) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.lightGreen[500],
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
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void _addPetition(title, description, BuildContext ctx) async {

    try {
      setState(() {
        _isLoading = true;
      });
      await Firestore.instance.collection(JOBSCOLLECTION).add({
        JOBTITLE : titleController.text.trim(),
        JOBDESCRIPTION : descriptionController.text.trim(),
        PAYDETAIL : paydetailController.text.trim(),
        JOBEXPERIENCE : experienceController.text.trim(),
        JOBLOCATION : locationController.text.trim(),
        JOBZIPCODE : zipController.text.trim(),
        JOBTIMINGFROM : timeFrom.format(context).toString(),
        JOBTIMINGTO : timeTo.format(context).toString(),
        JOBSTARTINGDATE : selectedDate,
        MONDAY : monday,
        TUESDAY : tuesday,
        WEDNESDAY : wednesday,
        THURSDAY : thursday,
        FRIDAY : friday,
        SATURDAY : saturday,
        SUNDAY : sunday,
        JOBSTATUS : OPEN,
        JOBPOSTDATE : DateTime.now(),

      });
      Navigator.pop(context);
//      Navigator.pushAndRemoveUntil(context,
//          MaterialPageRoute(builder: (context) {
//            return Home();
//          }), (route) => false);

      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (err) {
      var message = 'etl'.tr().toString();

      if (err.message != null) {
        message = err.message;
      }

      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Colors.red,
      ));

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);

      setState(() {
        _isLoading = false;
      });
    }
  }
}
//
//Widget _input(String hint) {
//  return Container(
//    height: 60,
//    decoration: BoxDecoration(
//        color: Colors.white,
//        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//        boxShadow: [
//          BoxShadow(
//              color: Colors.grey.withOpacity(0.2),
//              blurRadius: 10,
//              offset: Offset(2, 2))
//        ]),
//    child: Padding(
//      padding: const EdgeInsets.fromLTRB(10, 8, 15, 0),
//      child: TextFormField(
//        decoration: InputDecoration(
//            border: InputBorder.none,
//            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
//            //labelText: label,
//            hintText: hint,
//            focusColor: Colors.grey,
//
//            //fillColor: Colors.white,
//
//            fillColor: Colors.white),
//        //keyboardType: TextInputType.emailAddress,
//        style: TextStyle(
//          fontFamily: "Poppins",
//        ),
//      ),
//    ),
//  );
//}
//
//Widget _descriptioninput(String hint) {
//  return Container(
//    height: 140,
//    decoration: BoxDecoration(
//        color: Colors.white,
//        borderRadius: BorderRadius.all(Radius.circular(5.0)),
//        boxShadow: [
//          BoxShadow(
//              color: Colors.grey.withOpacity(0.2),
//              blurRadius: 10,
//              offset: Offset(2, 2))
//        ]),
//    child: Padding(
//      padding: const EdgeInsets.fromLTRB(10, 8, 15, 0),
//      child: TextFormField(
//        maxLines: 5,
//        keyboardType: TextInputType.multiline,
//        decoration: InputDecoration(
//            border: InputBorder.none,
//            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
//            //labelText: label,
//            hintText: hint,
//            focusColor: Colors.grey,
//
//            //fillColor: Colors.white,
//
//            fillColor: Colors.white),
//        //keyboardType: TextInputType.emailAddress,
//        style: TextStyle(
//          fontFamily: "Poppins",
//        ),
//      ),
//    ),
//  );
//}


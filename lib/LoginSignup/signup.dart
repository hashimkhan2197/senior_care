import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:seniorcare/constant.dart';
import 'package:seniorcare/jobs/jobs_list.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'PrivacyPolicies.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Country _selected = Country(
    asset: "assets/flags/as_flag.png",
    dialingCode: "1",
    isoCode: "AS",
    name: "American Samoa",
    currency: "United States dollar",
    currencyISO: "USD",
  );
  ///variables
  bool signupLoading = false;
  var _formKey = GlobalKey<FormState>();
  ///Text Editing Controllers
  TextEditingController firstNameController = TextEditingController(text:'');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController certificationsController = TextEditingController(text: '');
  TextEditingController experienceController = TextEditingController(text: '');
  TextEditingController othersController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController zipController = TextEditingController(text: '');
  TextEditingController availabilityController = TextEditingController(text: '');

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneController.dispose();
    certificationsController.dispose();
    experienceController.dispose();
    othersController.dispose();
    passwordController.dispose();
    zipController.dispose();
    availabilityController.dispose();
    super.dispose();
  }

  bool sunday = true;
  bool monday = true;
  bool tuesday = true;
  bool wednesday = true;
  bool thursday = true;
  bool friday = true;
  bool saturday = true;
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



  ///image picker
  File _image;
  String _imageUrl = "";

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {


      final FirebaseStorage _storgae =
      FirebaseStorage(storageBucket: 'gs://senior-service-c083d.appspot.com/');
      StorageUploadTask uploadTask;
      String filePath = '${DateTime.now()}.png';
      uploadTask = _storgae.ref().child(filePath).putFile(image);
      uploadTask.onComplete.then((_) async {
        print(1);
        String url1 = await uploadTask.lastSnapshot.ref.getDownloadURL();
        print(url1);
        _imageUrl = url1;
        setState(() {
          _image = image;
        });
      });
    }
  }

  ///BUILD STARTS HERE
  @override
  Widget build(BuildContext context) {
    Widget countryTextFormField() {
      return new Center(
        child: CountryPicker(
          dense: false,
          showFlag: true, //displays flag, true by default
          showDialingCode: true, //displays dialing code, false by default
          showName: false, //displays country name, true by default
          showCurrency: false, //eg. 'British pound'
          showCurrencyISO: false, //eg. 'GBP'
          onChanged: (Country country) {
            setState(() {
              _selected = country;
            });
          },
          selectedCountry: _selected,
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(
          'rpageheading'.tr().toString(),
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 120,
                    height: 120,
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _imageUrl != ''?GestureDetector(
                  onTap: getImage,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image(
                        image: NetworkImage(_imageUrl),
                        width: 120,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ):Center(
                  child: InkWell(
                    onTap: getImage,
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(0, 0),
                          blurRadius: 5,
                        ),
                      ]),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child:Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'raddprofilepicture'.tr().toString(),

                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'rfirstname'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _input(
                    'rfirst'.tr().toString(),firstNameController
                ),
                SizedBox(height: 15),
                Text(
                  'rlastname'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _input(
                    'rlast'.tr().toString(),lastNameController
                ),
                SizedBox(height: 15),
                Text(
                  'remail'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _input(
                  "email@email.com",emailController
                ),
                SizedBox(height: 15),
                Text(
                  'rphone'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      countryTextFormField(),
                      SizedBox(width: 10),
                      _phonenumberInput('rphone'.tr().toString(),phoneController),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'raddress'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _descriptioninput(
                    'radd'.tr().toString(),addressController
                ),
                SizedBox(height: 15),
                Text(
                  'rzipcode'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _input(
                    'rzc'.tr().toString(),zipController
                ),
                SizedBox(height: 15),
                Text(
                  'ravailability'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _input(
                    "e.g :\t 8:00 AM - 4:00 PM",availabilityController
                ),
                SizedBox(height: 15,),
                Text(
                  'rselectdays'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
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
                  'rcertifications'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _descriptioninput(
                    'rcer'.tr().toString(), certificationsController
                ),
                SizedBox(height: 15),
                Text(
                  'rexperience'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _descriptioninput(
                    'typedetails'.tr().toString(),experienceController
                ),
                SizedBox(height: 15),
                Text(
                  'rothers'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _descriptioninput(
                    'typedetails'.tr().toString(), othersController, optional: true
                ),
                SizedBox(height: 15),
                Text(
                  'password'.tr().toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 7),
                _input(
                    'password'.tr().toString(),passwordController
                ),
                SizedBox(height: 30),

                Center(
                  child: Text('byregistering'.tr().toString(),
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),),
                ),
                SizedBox(height: 6,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicies(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text('privacypolicy'.tr().toString(),textAlign: TextAlign.center, style: new TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.pink, fontSize: 16)),
                  ),
                ),
                SizedBox(height: 8),
                signupLoading
                    ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF166138))))
                    : Center(
                      child: Padding(
                  padding: EdgeInsets.fromLTRB(60, 10, 60, 15),
                  child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.grey[700],
                      textColor: Colors.white,
                      child: Text('apply'.tr().toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                      onPressed: () {
                        _formKey.currentState.save();
                        if (_imageUrl != "" && _formKey.currentState.validate()) {
                          print('form is valid');
                          signUp();
                        }else{
                          if(_imageUrl == '')
                              showDialog(
                              context: context,
                              builder:(context){return  AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius
                                        .circular(18.0),
                                    side: BorderSide(
                                      color: Colors.red[400],
                                    )),
                                title: Text('wait'.tr().toString()),
                                content:
                                Text('inu'.tr().toString()),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                          color:
                                          Colors.red[400]),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );});
                        }
                        },
                  ),
                ),
                    ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }


  ///Firebase creating user with email & password and error handling
  Future<void> signUp() async {
    setState(() {
      signupLoading = true;
    });
    try {
      final AuthResult user =
      (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ));

      if (user != null) {
        String userUid = user.user.uid;

        await addUsertoFirebase(userUid);

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
              return JobsList();
            }), (route) => false);
        setState(() {
          signupLoading = false;
        });
      }
    } catch (signUpError) {
      setState(() {
        signupLoading = false;
      });

      //Error handling
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          showDialog(
              context: context,
              builder: (context){return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text('eau'.tr().toString()),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );});
        }

        if (signUpError.code == 'ERROR_WEAK_PASSWORD') {
          showDialog(
              context: context,
              builder:(context) {return  AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text('wpass'.tr().toString()),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );}
              );
        }

        if (signUpError.code == 'ERROR_INVALID_EMAIL') {
          showDialog(
              context: context,
              builder:(context){return  AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text('invem'.tr().toString()),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );});
        }
      }
    }
  }


  ///function to add user data to a firebase collection
  Future<void> addUsertoFirebase(String userUid) async {
    await Firestore.instance.collection("users").document(userUid).setData({
      USERPICURL : _imageUrl,
      FIRSTNAME : firstNameController.text.trim(),
      LASTNAME : lastNameController.text.trim(),
      USEREMAIL : emailController.text.trim(),
      PHONENUMBER : _selected.dialingCode +phoneController.text.trim(),
      USERADDRESS : addressController.text.trim(),
      USERZIPCODE : zipController.text.trim(),
      USERCERTIFICATIONS : certificationsController.text.trim(),
      USEREXPERIENCE : experienceController.text.trim(),
      USERAVAILABILITY : availabilityController.text.trim(),
      USEROTHERS : othersController.text.trim(),
      PASSWORD : passwordController.text.trim(),
      SIGNUPDATE : DateTime.now(),
      JOBSTATUS : PENDING,
      MONDAY : monday,
      TUESDAY : tuesday,
      WEDNESDAY : wednesday,
      THURSDAY : thursday,
      FRIDAY : friday,
      SATURDAY : saturday,
      SUNDAY : sunday,
    });
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

  Widget _phonenumberInput(String hint,TextEditingController controller,{bool optional=false}) {
    return Container(
      width: 180,
      height: 60,
      margin: EdgeInsets.only(top: 6, bottom: 0),
      decoration: BoxDecoration(),
      //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.isEmpty && optional == false) {
            return 'empty'.tr().toString();
          }
          return null;
        },
        keyboardType: TextInputType.phone,
        //controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }

  Widget _addressinput(String hint,TextEditingController controller,{bool optional=false}) {
    return Container(
      height: 80,
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

}

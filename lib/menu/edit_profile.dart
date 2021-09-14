import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:seniorcare/jobs/jobs_list.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:seniorcare/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:seniorcare/show_dialog_widget.dart';

class EditProfile extends StatefulWidget {
  final AsyncSnapshot userSnapshot;

  EditProfile(this.userSnapshot);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  TextEditingController phoneController ;
  TextEditingController addressController ;
  TextEditingController certificationsController;
  TextEditingController experienceController ;
  TextEditingController othersController ;
  TextEditingController zipController;
  TextEditingController availabilityController;
  bool sunday ;
  bool monday ;
  bool tuesday ;
  bool wednesday ;
  bool thursday ;
  bool friday ;
  bool saturday ;
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



  @override
  void initState() {
    monday = widget.userSnapshot.data[MONDAY];
    tuesday = widget.userSnapshot.data[TUESDAY];
    wednesday = widget.userSnapshot.data[WEDNESDAY];
    thursday = widget.userSnapshot.data[THURSDAY];
    friday = widget.userSnapshot.data[FRIDAY];
    saturday = widget.userSnapshot.data[SATURDAY];
    sunday = widget.userSnapshot.data[SUNDAY];

    _imageUrl = widget.userSnapshot.data[USERPICURL];

    phoneController = TextEditingController(text: widget.userSnapshot.data[PHONENUMBER]);
    addressController = TextEditingController(text: widget.userSnapshot.data[USERADDRESS]);
    certificationsController = TextEditingController(text: widget.userSnapshot.data[USERCERTIFICATIONS]);
    experienceController = TextEditingController(text: widget.userSnapshot.data[USEREXPERIENCE]);
    othersController = TextEditingController(text: widget.userSnapshot.data[USEROTHERS]);
    zipController = TextEditingController(text: widget.userSnapshot.data[USERZIPCODE]);
    availabilityController = TextEditingController(text: widget.userSnapshot.data[USERAVAILABILITY]);
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    certificationsController.dispose();
    experienceController.dispose();
    othersController.dispose();
    zipController.dispose();
    availabilityController.dispose();
    super.dispose();
  }

  ///image picker
  File _image;
  String _imageUrl = "";

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    String fileName = '${DateTime.now().toString()}.png';

    if(image!= null){

      ///Saving Pdf to firebase
      StorageReference reference =  FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = reference.putData(image.readAsBytesSync());
      String urlImage = await (await uploadTask.onComplete).ref.getDownloadURL();
      print(urlImage);
      setState(() {
        _image = image;
        _imageUrl = urlImage;
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
          showFlag: true,
          //displays flag, true by default
          showDialingCode: true,
          //displays dialing code, false by default
          showName: false,
          //displays country name, true by default
          showCurrency: false,
          //eg. 'British pound'
          showCurrencyISO: false,
          //eg. 'GBP'
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
          'eprof'.tr().toString(),
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
                width: 100,
                height: 100,
                child: Image(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: getImage,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      image: NetworkImage(_imageUrl),
                      width: 110,
                      height: 150,
                      fit: BoxFit.cover,
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
              _output(
                  widget.userSnapshot.data[FIRSTNAME],
              ),
              SizedBox(height: 15),
              Text(
                'rlastname'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _output(
                  widget.userSnapshot.data[LASTNAME],
              ),
              SizedBox(height: 15),
              Text(
                'remail'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _output(
                  "email@email.com"
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
                child:  _phonenumberInput( 'rphone'.tr().toString(),phoneController),
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
                  'raddress'.tr().toString(),addressController
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

              SizedBox(height: 15),
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
                        child: sunday!=true
                            ? _unselectedday('S')
                            : _selectedday('S')
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            monday = !monday;
                          });
                        },
                        child: monday!=true
                            ? _unselectedday('M')
                            : _selectedday('M')
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            tuesday = !tuesday;
                          });
                        },
                        child: tuesday!=true
                            ? _unselectedday('T')
                            : _selectedday('T')
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            wednesday= !wednesday;
                          });
                        },
                        child: wednesday!=true
                            ? _unselectedday('W')
                            : _selectedday('W')
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            thursday = !thursday;
                          });
                        },
                        child: thursday!=true
                            ? _unselectedday('T')
                            : _selectedday('T')
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            friday = !friday;
                          });
                        },
                        child: friday!=true
                            ? _unselectedday('F')
                            : _selectedday('F')
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            saturday = !saturday;
                          });
                        },
                        child: saturday!=true
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

              SizedBox(height: 25),
              signupLoading
                  ? Center(child: CircularProgressIndicator()):
              Padding(
                padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.grey[700],
                  textColor: Colors.white,
                  child: Text( 'done'.tr().toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                      )),
                  onPressed: () {
                    if (_imageUrl != "" && _formKey.currentState.validate()) {
                      updateUsertoFirebase(widget.userSnapshot.data.documentID);
                    } else if(_imageUrl == ''){
                      showDialog(
                          context: context,
                          builder:(context){return ShowDialogWidget(borderColor: Colors.red[400],titleText:  'reminder'.tr().toString(),
                            subText:  'pinu'.tr().toString(),);});
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }



  ///function to add user data to a firebase collection
  Future<void> updateUsertoFirebase(String userUid) async {
    setState(() {
      signupLoading=true;
    });
    await Firestore.instance.collection("users").document(userUid).updateData({
      USERPICURL : _imageUrl,
      PHONENUMBER : phoneController.text.trim(),
      USERADDRESS : addressController.text.trim(),
      USERCERTIFICATIONS : certificationsController.text.trim(),
      USEREXPERIENCE : experienceController.text.trim(),
      USEROTHERS : othersController.text.trim(),
      USERZIPCODE: zipController.text.trim(),
      USERAVAILABILITY: availabilityController.text.trim(),
      MONDAY : monday,
      TUESDAY : tuesday,
      WEDNESDAY : wednesday,
      THURSDAY : thursday,
      FRIDAY : friday,
      SATURDAY : saturday,
      SUNDAY : sunday,
    }).then((value) {
      Navigator.pop(context);
    }).catchError((e){
      setState(() {
        signupLoading = false;
      });
      print(e);
      showDialog(
          context: context,
          builder:(context){return ShowDialogWidget(
            borderColor: Colors.red[400],
            titleText: 'err'.tr().toString(),
            subText:'etl'.tr().toString(),
          );});
    });
  }


  ///INPUT OUTPUT FUNCTIONS HERE
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
              return  'empty'.tr().toString();
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
            return  'empty'.tr().toString();
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
              return  'empty'.tr().toString();
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
              return  'empty'.tr().toString();
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
  Widget _output(String hint) {
    return Container(
      height: 55,
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
        padding: const EdgeInsets.fromLTRB(10, 15, 15, 0),
        child: Text(hint,style: TextStyle(fontSize: 16),),
      ),
    );
  }


}


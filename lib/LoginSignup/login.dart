import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seniorcare/LoginSignup/signup.dart';
import 'package:seniorcare/jobs/jobs_list.dart';
import 'package:easy_localization/easy_localization.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  final _scacffoldKey = GlobalKey<ScaffoldState>();
  var _isLoading = false;

  String lang;

  ///Text Editing Controllers
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  ///BUILD STARTS HERE
  @override
  Widget build(BuildContext context) {
    lang = 'lang'.tr().toString();
    return Scaffold(
      key: _scacffoldKey,
      appBar: AppBar(
        actions: [
          DropdownButtonHideUnderline(
              child: DropdownButton(
            value: lang,
            items: <DropdownMenuItem<String>>[
              new DropdownMenuItem(
                child: new Text('English'),
                value: 'ENG',
              ),
              new DropdownMenuItem(child: new Text('Spanish'), value: 'ESP'),
            ],
            onChanged: (String value) {
              setState(() {

                if(value== "ENG"){
                  EasyLocalization.of(context).locale =
                      Locale("en", "US");
                }
                if(value=="ESP") {
                  EasyLocalization.of(context).locale =
                      Locale("es", "ESP");
                }
              });
            },
          )),
        ],
        title: Text(
          'login'.tr().toString(),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 20),
              SizedBox(height: 10),
              Container(
                width: 150,
                height: 150,
                child: Image(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'yourEmail'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _input("email@email.com", emailController),
              SizedBox(height: 15),
              Text(
                'password'.tr().toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 7),
              _input('enterpassword'.tr().toString(), passwordController),
              SizedBox(height: 25),
              _isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Color(0xFF166138))),
                    )
                  : RaisedButton(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.grey[700],
                      textColor: Colors.white,
                      child: Text('loginbutton'.tr().toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          //Only gets here if the fields pass
                          _formKey.currentState.save();
                          _login(emailController.text, passwordController.text,
                              context);
                        }
                      },
                    ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _resetPassword(emailController.text.trim(), context);
                },
                child: Center(
                  child: Text(
                    'forgotpassword'.tr().toString(),
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('donthaveaccount'.tr().toString(),
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    child: Text(
                      'register'.tr().toString(),
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller) {
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
            if (value.isEmpty) {
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

  void _login(email, password, BuildContext ctx) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return JobsList();
      }), (route) => false);
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//        return HomePage();
//      }));
    } on PlatformException catch (err) {
      var message = 'ecc'.tr().toString();

      if (err.message != null) {
        message = err.message;
      }

      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Theme.of(ctx).errorColor,
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

  void _resetPassword(String email, BuildContext ctx) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          'recemail'.tr().toString(),
        ),
        backgroundColor: Theme.of(ctx).primaryColor,
      ));
    } on PlatformException catch (err) {
      var message = 'ecc'.tr().toString();

      if (err.message != null) {
        message = err.message;
      }

      if (email == null || email.isEmpty) {
        message = 'ere'.tr().toString();
      }

      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Theme.of(ctx).errorColor,
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

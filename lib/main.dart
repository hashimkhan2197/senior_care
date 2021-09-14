import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seniorcare/AdminPenal/main_page.dart';
import 'package:seniorcare/LoginSignup/login.dart';
import 'package:seniorcare/constant.dart';
import 'package:seniorcare/jobs/jobs_list.dart';
import 'package:seniorcare/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('es', 'ESP')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      saveLocale: true,
      child: SeniorCare()));
}

class SeniorCare extends StatelessWidget {
  const SeniorCare({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        cursorColor: Colors.grey,
        dialogBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(primary: Colors.lightGreen[500]),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        highlightColor: Colors.grey[400],
        textSelectionColor: Colors.grey,
      ),
      title: 'main page',
      routes: <String, WidgetBuilder>{                    
        SPLASH_SCREEN: (BuildContext context) => MainPage(),
        LOGIN: (BuildContext context) => Login(),
        //ADMINPANEL: (BuildContext context) => AdminpanelMainpage(),
      },
      home:StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return JobsList();
          }
          return Login();
        },
      ),
    );
  }
}
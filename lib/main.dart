import 'package:flutter/material.dart';

import 'package:yt_tt2/screens/splashscreen.dart';
import 'package:yt_tt2/screens/authscreen.dart';

import 'package:firebase_core/firebase_core.dart';

// Defining routes for navigation
var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'FaceBase',
      routes: routes,
      home: SplashScreen(),
      theme: ThemeData(
        // Define the default brightness and colors.
        //brightness: Brightness.dark,
        //primarySwatch: Colors.red,
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red, brightness: Brightness.dark),
        // Define the default font family.
        //fontFamily: 'Roboto',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        /*textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
        ),*/
      ),
    ),
  );
}

import 'package:yt_tt2/home.dart';
import 'package:flutter/material.dart';

import 'package:yt_tt2/services/google_sign_in.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

String url =
    'https://youtube.googleapis.com/youtube/v3/subscriptions?part=id%2C%20snippet&mine=true&key=AIzaSyDfMIMsXiDbr5trTOuNMTda7npBojGtM7Y';

Future<String> getSubscriptions(String token) async {
  final response = await http.get(
    url,
    headers: {HttpHeaders.authorizationHeader: "Bearer " + token},
  );
  return response.body;
  /*var allVideos = allVideosFromJson(response.body);
  //print(allVideos['list']);
  print("getVideos END");
  return {
    "videos": allVideos['list'],
    "nextPageToken": allVideos['nextPageToken']
  };*/
}

/*String name;
String email;
String imageUrl;*/

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //bool isVisible = false;
  bool loggingIn = false;

  Widget signInButton() {
    var swidth = MediaQuery.of(context).size.width;
    return Align(
        alignment: Alignment.center,
        child: SizedBox(
            height: 54.0,
            width: swidth / 1.45,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  this.loggingIn = true;
                });
                signIn().then((user) {
                  print('sign in complete');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => MainPage(loggedUser: user)),
                      (Route<dynamic> route) => false);
                }).catchError((onError) {
                  print('sign in ERROR');
                  setState(() {
                    this.loggingIn = false;
                  });
                  //Navigator.pushReplacementNamed(context, "/auth");
                });
              },
              child: Text(
                ' Continue With Google',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              elevation: 5,
              color: Colors.white, // Color(0XFFF7C88C),
            )));
  }

  Widget loadingCircle() {
    return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB2F2D52)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover)),
          ),
          Visibility(
            child: loadingCircle(),
            visible: loggingIn,
          ),
          Visibility(
            child: signInButton(),
            visible: !loggingIn,
          ),
        ],
      ),
    );
  }
}

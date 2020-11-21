import 'package:flutter/material.dart';

import 'package:yt_tt2/services/google_sign_in.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signOut().then((value) {
              Navigator.pushReplacementNamed(context, "/auth");
            });
          },
          child: Text('Loggout'),
        ),
      ),
    );
  }
}

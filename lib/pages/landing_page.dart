import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/pages/home_page.dart';
import 'package:time_tracker/pages/signin_page.dart';
import 'package:time_tracker/services/auth_base.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.onAuthChange,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return SignInPage(auth: auth);
            } else {
              return HomePage(
                auth: auth,
              );
            }
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

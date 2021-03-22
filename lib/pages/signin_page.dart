import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth_base.dart';
import 'package:time_tracker/widgets/custom_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key key, @required this.auth, @required this.onSignIn})
      : super(key: key);

  final AuthBase auth;

  final void Function(User) onSignIn;

  Future<User> _signIn() async {
    final user = await auth.signIn();
    onSignIn(user);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Time Tracker'),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomButton(
                title: 'Sign in with Google',
                onPressed: () {},
              ),
              CustomButton(
                title: 'Sign in with Facebok',
                onPressed: () {},
              ),
              CustomButton(
                title: 'Sign in with email',
                onPressed: () {},
              ),
              CustomButton(
                title: 'Go anonymous',
                onPressed: _signIn,
              )
            ],
          ),
        ));
  }
}

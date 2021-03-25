import 'package:flutter/material.dart';
import 'package:time_tracker/pages/email_signin_page.dart';
import 'package:time_tracker/services/auth_base.dart';
import 'package:time_tracker/widgets/custom_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  Future<void> _signInAnonymous() async {
    try {
      auth.signInAnonymous();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      auth.signInWithGoogle();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      auth.signInWithFacebook();
    } catch (e) {
      print(e);
    }
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
                onPressed: _signInWithGoogle,
              ),
              CustomButton(
                title: 'Sign in with Facebok',
                onPressed: _signInWithFacebook,
              ),
              CustomButton(
                title: 'Sign in with email',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => EmailSignInPage(
                      auth: auth,
                    ),
                  ),
                ),
              ),
              CustomButton(
                title: 'Go anonymous',
                onPressed: _signInAnonymous,
              )
            ],
          ),
        ));
  }
}

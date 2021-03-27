import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/pages/email_signin_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_base.dart';
import 'package:time_tracker/widgets/custom_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  AuthBase get auth => Provider.of<Auth>(context, listen: false);

  Future<void> _signInAnonymous() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await auth.signInAnonymous();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
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

  Widget _buildHeader() {
    if (_isLoading) {
      return CircularProgressIndicator();
    }
    return Text(
      'SIGN IN',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('isLoading $_isLoading');
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
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: _buildHeader(),
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

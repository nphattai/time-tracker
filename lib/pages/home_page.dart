import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth_base.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, @required this.auth, @required this.onSignOut})
      : super(key: key);

  final AuthBase auth;
  final void Function(User) onSignOut;

  void _signOut() async {
    await auth.signOut();
    onSignOut(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Home'),
        actions: <Widget>[
          TextButton(
            onPressed: _signOut,
            child: Text(
              'Sign out',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(auth.currentUser.uid),
        ),
      ),
    );
  }
}

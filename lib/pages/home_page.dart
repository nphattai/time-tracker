import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, @required this.onSignOut}) : super(key: key);

  final void Function(User) onSignOut;

  final User currentUser = FirebaseAuth.instance.currentUser;

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
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
          child: Text(currentUser.uid),
        ),
      ),
    );
  }
}

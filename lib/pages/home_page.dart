import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/auth_base.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(AuthBase auth) async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Home'),
        actions: <Widget>[
          TextButton(
            onPressed: () => _signOut(auth),
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

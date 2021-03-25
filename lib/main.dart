import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/pages/landing_page.dart';
import 'package:time_tracker/services/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Something wrong!'),
              ),
            );
          }
          if (snapshot.hasData) {
            return MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.teal,
              ),
              debugShowCheckedModeBanner: false,
              home: LandingPage(
                auth: Auth(),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}

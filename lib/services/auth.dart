import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker/services/auth_base.dart';

class Auth implements AuthBase {
  final auth = FirebaseAuth.instance;

  @override
  User get currentUser => auth.currentUser;

  @override
  Future<User> signIn() async {
    try {
      UserCredential userCredential = await auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      auth.signOut();
    } catch (e) {
      throw Error();
    }
  }
}

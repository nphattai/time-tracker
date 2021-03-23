import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Stream<User> get onAuthChange;
  User get currentUser;
  Future<User> signIn();
  Future<void> signOut();
}

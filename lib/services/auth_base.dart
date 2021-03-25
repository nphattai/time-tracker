import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Stream<User> get onAuthChange;
  User get currentUser;
  Future<User> signInAnonymous();
  Future<void> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserCredenntial(String email, String password);
}

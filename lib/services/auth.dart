import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_tracker/services/auth_base.dart';

class Auth implements AuthBase {
  final auth = FirebaseAuth.instance;

  @override
  Stream<User> get onAuthChange => auth.authStateChanges();

  @override
  User get currentUser => auth.currentUser;

  @override
  Future<User> signInAnonymous() async {
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
      await GoogleSignIn().signOut();
      await auth.signOut();
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  }

  @override
  Future<User> signInWithFacebook() async {
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    return userCredential.user;
  }

  @override
  Future<User> createUserCredenntial(String email, String password) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await auth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    return userCredential.user;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/blocs/sign_in_bloc.dart';
import 'package:time_tracker/pages/email_signin_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/widgets/custom_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, this.bloc}) : super(key: key);

  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Provider(
      create: (_) => SignInBloc(auth: auth),
      dispose: (_, SignInBloc bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (_, bloc, __) => SignInPage(
          bloc: bloc,
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    print(message);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('OK'))
        ],
      ),
    );
  }

  Future<void> _signInAnonymous(BuildContext context) async {
    try {
      bloc.signInAnonymous();
    } on FirebaseAuthException catch (e) {
      _showDialog(context, e.message);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      bloc.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      _showDialog(context, e.message);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      bloc.signWithFacebook();
    } on FirebaseAuthException catch (e) {
      _showDialog(context, e.message);
    }
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
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
    final bloc = Provider.of<SignInBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) => _buildContent(context, snapshot.data),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    final auth = Provider.of<Auth>(context);
    return Container(
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
              child: _buildHeader(isLoading),
            ),
          ),
          CustomButton(
            title: 'Sign in with Google',
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          CustomButton(
            title: 'Sign in with Facebok',
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
          ),
          CustomButton(
            title: 'Sign in with email',
            onPressed: isLoading
                ? null
                : () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => EmailSignInPage(
                          auth: auth,
                        ),
                      ),
                    ),
          ),
          CustomButton(
            title: 'Go anonymous',
            onPressed: isLoading ? null : () => _signInAnonymous(context),
          )
        ],
      ),
    );
  }
}

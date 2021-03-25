import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth_base.dart';
import 'package:time_tracker/widgets/custom_button.dart';

enum EmailSignInFormType { SIGN_IN, SIGN_UP }

class EmailSignInPage extends StatefulWidget {
  EmailSignInPage({Key key, @required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  _EmailSignInPageState createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.SIGN_IN;

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.SIGN_IN
          ? EmailSignInFormType.SIGN_UP
          : EmailSignInFormType.SIGN_IN;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _onSubmit() async {
    if (_formType == EmailSignInFormType.SIGN_IN) {
      final user =
          await widget.auth.signInWithEmailAndPassword(_email, _password);
      if (user != null) {
        Navigator.of(context).pop();
      }
    } else {
      final user = await widget.auth.createUserCredenntial(_email, _password);
      if (user != null) {
        _toggleFormType();
        FocusScope.of(context).requestFocus(_passwordFocusNode);
        _emailController.text = user?.email;
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String primaryText = _formType == EmailSignInFormType.SIGN_IN
        ? 'Sign in'
        : 'Create an account';
    String secondText = _formType == EmailSignInFormType.SIGN_IN
        ? 'Need an account? Regester'
        : 'Have an account? Sign in';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 2,
        title: Text('Sign in'),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(labelText: 'Email'),
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_passwordFocusNode),
                ),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  onEditingComplete: _onSubmit,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: _onSubmit,
                  title: primaryText,
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: _toggleFormType,
                  child: Text(
                    secondText,
                    style: TextStyle(color: Colors.teal),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

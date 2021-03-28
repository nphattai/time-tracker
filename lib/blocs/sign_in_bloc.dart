import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth_base.dart';

class SignInBloc {
  SignInBloc({@required this.auth});

  final AuthBase auth;

  final _isLoadingStreamController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingStreamController.stream;

  void dispose() {
    _isLoadingStreamController.close();
  }

  void setIsLoading(bool value) => _isLoadingStreamController.add(value);

  void _signin(Future<User> Function() signInMethod) async {
    try {
      setIsLoading(true);
      await signInMethod();
    } catch (e) {
      print(e);
      setIsLoading(false);
    }
  }

  void signInAnonymous() => _signin(auth.signInAnonymous);
  void signInWithGoogle() => _signin(auth.signInWithGoogle);
  void signWithFacebook() => _signin(auth.signInWithFacebook);
}

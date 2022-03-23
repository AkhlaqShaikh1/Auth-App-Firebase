import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

class SignUpAuth {
  final _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  SignUpAuth(this._emailController, this._passwordController);

  createUser() async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}

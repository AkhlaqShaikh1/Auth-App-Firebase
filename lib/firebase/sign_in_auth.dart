import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignInAuth {
  final FirebaseAuth firebaseAuth;

  SignInAuth({
    required this.firebaseAuth,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  // SignInAuth(this._emailController, this._passwordController);
  signInUser() async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // print("Sign In Succesfull");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  signOutUser() async {
    firebaseAuth.signOut();
  }
}

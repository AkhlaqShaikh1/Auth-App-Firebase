// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_app/firebase/sign_up_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../firebase/sign_in_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // final SignUpAuth _auth = SignUpAuth(emailController, passwordController);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Login Page"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 8.0),
            MyTextField(controller: emailController, text: "Email"),
            MyTextField(controller: passwordController, text: "Password"),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () async {
                final SignInAuth _auth = SignInAuth(
                    firebaseAuth: firebaseAuth,
                    passwordController: passwordController,
                    emailController: emailController);
                await _auth.signInUser();
                // print("I");
                // emailController.clear();
                // passwordController.clear();
                setState(() {
                  if (kDebugMode) {
                    print(firebaseAuth.currentUser);
                  }
                });
              },
              child: const Text("SignIn"),
            ),
            ElevatedButton(
              onPressed: () {
                final SignUpAuth _auth =
                    SignUpAuth(emailController, passwordController);
                _auth.createUser();
                // print("I");+
                emailController.clear();
                passwordController.clear();
                setState(() {
                  if (kDebugMode) {
                    print(firebaseAuth.currentUser!.email.toString());
                  }
                });
              },
              child: const Text("SignUp"),
            ),
            ElevatedButton(
              onPressed: () async {
                final SignInAuth _auth = SignInAuth(
                    firebaseAuth: firebaseAuth,
                    passwordController: passwordController,
                    emailController: emailController);
                await _auth.signOutUser();
                // print("I");
                // emailController.clear();
                // passwordController.clear();
                setState(() {
                  if (kDebugMode) {
                    print(firebaseAuth.currentUser);
                  }
                });
              },
              child: const Text("Sign OUT"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.controller,
    required this.text,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0),
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
}

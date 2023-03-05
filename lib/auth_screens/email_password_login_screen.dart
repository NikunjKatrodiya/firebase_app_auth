import 'package:firebase_app_auth/app_flow/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'email_password_signin_screen.dart';

class EmailPasswordLogInScreen extends StatefulWidget {
  const EmailPasswordLogInScreen({Key? key}) : super(key: key);

  @override
  State<EmailPasswordLogInScreen> createState() =>
      _EmailPasswordLogInScreenState();
}

class _EmailPasswordLogInScreenState extends State<EmailPasswordLogInScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Password Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter Email",
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Enter Password",
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(200, 45)),
              ),
              child: const Text("Login In"),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmailPasswordSignInScreen(),
                  ),
                );
              },
              child: const Text(
                "Create a new account",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  userLogIn() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (auth.currentUser!.emailVerified) {
        debugPrint("currentUser ----------->>> ${auth.currentUser}");
        navigator();
      } else {
        debugPrint("Please verify your email");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("e.code ----------->>> ${e.code}");
      if (e.code == 'invalid-email') {
        debugPrint('The invalid email provided.');
      } else if (e.code == 'user-not-found') {
        debugPrint('Email is not exist in the app');
      } else if (e.code == 'wrong-password') {
        debugPrint('The password provided is Wrong');
      } else if (e.code == 'unknown') {
        debugPrint('Please put data in field');
      }
    } catch (e) {
      debugPrint("Error ----->> $e");
    }
  }

  navigator() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }
}

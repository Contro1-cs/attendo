import 'package:attendo/modules/shared/screens/home_screen.dart';
import 'package:attendo/modules/shared/widgets/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  firebaseSignup() {
    var auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
      email: "admin@admin.com",
      password: "123123",
    )
        .then((UserCredential userCredential) {
      debugPrint(userCredential.user!.email);
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }).onError((FirebaseAuthException error, stackTrace) {
      if (error.code == 'email-already-in-use') {
        firebaseLogin();
        return;
      }

      errorSnackBar(context, error.message!);
      debugPrint(error.message);
    });
  }

  firebaseLogin() {
    var auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
      email: "admin@admin.com",
      password: "123123",
    )
        .then((UserCredential userCredential) {
      debugPrint(userCredential.user!.email);
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }).onError((FirebaseAuthException error, stackTrace) {
      errorSnackBar(context, error.message!);
      debugPrint(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            firebaseSignup();
          },
          child: const Text('Signup'),
        ),
      ),
    );
  }
}

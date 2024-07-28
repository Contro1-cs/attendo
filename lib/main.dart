import 'package:attendo/modules/onboarding/screens/login.dart';
import 'package:attendo/modules/home/screens/home_screen.dart';
import 'package:attendo/modules/shared/widgets/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool signedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      signedIn = false;
    } else {
      signedIn = true;
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendo',
      theme: ThemeData(
        fontFamily: 'eudoxus',
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors.primary,
          background: CustomColors.white,
          primary: CustomColors.primary,
          secondary: CustomColors.darkBlue,
          error: CustomColors.red,
        ),
        useMaterial3: true,
      ),
      home: signedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}

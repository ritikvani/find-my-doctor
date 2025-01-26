import 'package:findmydoctor/screens/login/login_screen.dart';
import 'package:findmydoctor/screens/registration/doctor_registration.dart';
import 'package:findmydoctor/screens/registration/patient_registration.dart';
import 'package:findmydoctor/screens/splash_screen.dart';
import 'package:findmydoctor/stateManagement/getx_file.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:healthcare/screens/homeScreen/home_screen.dart';
// import 'package:healthcare/screens/login_screen.dart';
// import 'package:healthcare/screens/splash_screen.dart';
// import 'package:healthcare/screens/welcome_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
void main() async {

   WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter bindings are initialized.
   await Firebase.initializeApp(); // Initializes Firebase.

  runApp(
    GetMaterialApp(
      home: MainScreen(),
      theme: ThemeData(
        useMaterial3: true, // Enable Material 3

      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

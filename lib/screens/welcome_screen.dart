import 'package:findmydoctor/screens/login/login_screen.dart';
import 'package:findmydoctor/screens/login_screen.dart';
import 'package:findmydoctor/screens/registration/patient_registration.dart';
import 'package:findmydoctor/utility/common_button.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:healthcare/screens/login_screen.dart';
// import 'package:healthcare/utility/common_button.dart';
// import 'package:healthcare/utility/common_colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "lib/assets/images/welcome.png",
              scale: 2.5,
            ),
            const SizedBox(height: 19),
            const Text(
              "Skin\nFirst",
              style: TextStyle(
                fontSize: 48,
                fontFamily: "Poppins",
                color: Color(0xff2260FF),
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 19),
            const Text(
              "Dermatology Center",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff2260FF),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 84),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff000000),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // CommonButton(
            //     buttonText: "Log In",
            //     backgroundColor: const Color(0xff2260FF),
            //     onPressed: () {
            //       Get.to(() => LogInScreen()); // Corrected here
            //     },
            //     textColor: Color(0xffFFFFFF)),
            const SizedBox(height: 10),
            CommonButton(
                buttonText: "Sign Up",
                backgroundColor: Color(0xffCAD6FF),
                onPressed: () {
                  Get.to(()=>PatientRegistration());
                },
                textColor: Color(0xff2260FF)),
            IconButton( onPressed: () async {
              var user = await signInWithGoogle();
             print("user $user");
            }, icon: Image.asset("lib/assets/images/welcome.png")) ,
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.to(()=>LoginScreen());
              },
              child: Text(
                "Already have an account? Log in",
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: primaryColor, fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
}

import 'package:findmydoctor/screens/homeScreen/home_screen.dart';
import 'package:findmydoctor/utility/common_button.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../userModule/doctor/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool error = false;
  String errorMessage = "";
  bool _isLoading = false;
  bool patient = true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        surfaceTintColor: secondaryColor,
        elevation: 0,
        title: const Text(
          "Log In to Your Account",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: const Color(0xFFF0F0F0),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    "lib/assets/images/welcome.png",
                    scale: 2.7,
                  ),
                  customTextField(
                      labelText: "Email",
                      hintText: "Enter your email address",
                      controller: emailController),
                  customTextField(
                      labelText: "Password",
                      hintText: "Enter your password",
                      controller: passwordController,
                     ),
                  const SizedBox(height: 5),
                  Text(
                    error ? errorMessage : "",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 5),
                  CommonButton(
                      buttonText: "Log In",
                      backgroundColor: const Color(0xff2260FF),
                      onPressed: (){
                        handleLogin(isPatient: patient);
                      },
                      textColor: const Color(0xffFFFFFF)),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {
                      setState(()=>{
                        patient = !patient
                      });
                    },
                    child: Text(
                      patient?  "Log in as a doctor" : "Log in as a patient",
                      style:
                      TextStyle(fontWeight: FontWeight.w500, color: primaryColor, fontSize: 16),
                    ),
                  ),

                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child:  Center(
                child:LoadingAnimationWidget.newtonCradle(
                  color: Colors.white,
                  size: 150,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> handleLogin({required bool isPatient}) async {
    setState(() {
      _isLoading = true;
      error = false;
      errorMessage = "";
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        error = true;
        errorMessage = "Please fill in all the details.";
        _isLoading = false;
      });
      return;
    }

    FocusScope.of(context).unfocus();
    try {
      var response = await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );


      print( "this is response $response");
      String? uniqueKey = response.user?.uid;
      if (uniqueKey != null) {
        sharedPreferences.setString("token", uniqueKey);
        sharedPreferences.setBool("isPatient", isPatient);
        Get.to(() =>

            isPatient ? HomeScreen(userToken: uniqueKey) :  DoctorsDashBoard(token: uniqueKey,));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        error = true;
        if (e.code == "wrong-password") {
          errorMessage = "The password is incorrect. Please try again.";
        } else if (e.code == "user-not-found") {
          errorMessage = "No account found with this email address.";
        } else if (e.code == "invalid-email") {
          errorMessage = "The email address is invalid.";
        } else {
          errorMessage = "An error occurred: ${e.message}";
        }
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        this.error = true;
        errorMessage = "An unexpected error occurred: $error";
      });
    }
  }
}

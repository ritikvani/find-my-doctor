import 'package:findmydoctor/screens/homeScreen/home_screen.dart';
import 'package:findmydoctor/utility/common_button.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool error = false;
  bool _isLoading = false;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: Column(children: [
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
                  controller: passwordController),
              const SizedBox(
                height: 5,
              ),
              Text(
                error ? "Please check your credentials*" : "",
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(
                height: 5,
              ),
              CommonButton(
                  buttonText: "Log In",
                  backgroundColor: const Color(0xff2260FF),
                  onPressed: handleLogin,
                  textColor: const Color(0xffFFFFFF)),
              if (_isLoading)
                const Opacity(
                  opacity: 0.8,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> handleLogin() async {
    print("button pressed") ;
    setState(() {
      _isLoading = true;
    });
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // if (emailController.text.isEmpty || passwordController.text.isEmpty) {
    //   setState(() => {error = true});
    //   print("Please fill in all the details.");
    //   return;
    // }
    // FocusScope.of(context).unfocus();
    // // print(emailController.text + passwordController.text + "this is your credentials");
    // try {
    //   var response = await firebaseAuth.signInWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );
    //
    //   String? uniqueKey = response.user?.uid;
    //   if (uniqueKey != null) {
    //     Get.to(HomeScreen(
    //       userToken: uniqueKey,
    //     ));
    //     sharedPreferences.setString("token", uniqueKey);
    //   }
    //   print("Login successful ${response}");
    // } on FirebaseAuthException catch (e) {
    //   // Handle specific FirebaseAuth errors
    //   if (e.code == "wrong-password") {
    //     print("The password is incorrect. Please try again.");
    //   } else if (e.code == "user-not-found") {
    //     print("No account found with this email address.");
    //   } else if (e.code == "invalid-email") {
    //     print("The email address is invalid.");
    //   } else {
    //     print("An error occurred: ${e.message}");
    //   }
    // } catch (error) {
    //   print("An unexpected error occurred: $error");
    // }
  }
}

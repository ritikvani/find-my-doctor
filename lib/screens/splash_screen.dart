import 'package:findmydoctor/screens/login/login_screen.dart';
import 'package:findmydoctor/screens/select_user.dart';
import 'package:findmydoctor/screens/welcome_screen.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:healthcare/screens/welcome_screen.dart';
// import 'package:healthcare/utility/common_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceDimensions = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/images/splash.png",
              scale: 2.5,
            ),
            const SizedBox(height: 19),
            const Text(
              "Skin\nFirst",
              style: TextStyle(
                fontSize: 48,
                fontFamily: "Poppins",
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 19),
            const Text(
              "Dermatology Center",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

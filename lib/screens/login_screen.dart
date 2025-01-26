import 'package:findmydoctor/screens/homeScreen/home_screen.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:healthcare/screens/homeScreen/home_screen.dart';
// import 'package:healthcare/utility/common_colors.dart';

import '../utility/common_button.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new),
            color: primaryColor),
        title: Text(
          "Log In",
          style: TextStyle(color: primaryColor),
        ),
        // title: ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Email or Mobile Number",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  hintText: "example@example.com",
                  fillColor: const Color(0xffECF1FF),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(13))),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Password ",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(

                  filled: true,
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                  hintText: "*******",
                  fillColor: const Color(0xffECF1FF),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(13))),
            ),
            const SizedBox(height: 50),
            Align(alignment: Alignment.center,
              child: Column(
                children: [
                  CommonButton(
                      buttonText: "Log In",
                      backgroundColor: const Color(0xff2260FF),
                      onPressed: () {
                     // Get.to(()=>{
                     //   const HomeScreen()
                     // } );
                      },
                      textColor: const Color(0xffFFFFFF)),
                  const SizedBox(height: 16),
                  // Text("or sign up with"),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

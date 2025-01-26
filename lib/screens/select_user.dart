import 'package:findmydoctor/screens/registration/doctor_registration.dart';
import 'package:findmydoctor/screens/registration/patient_registration.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectUSer extends StatefulWidget {
  const SelectUSer({Key? key}) : super(key: key);

  @override
  State<SelectUSer> createState() => _SelectUSerState();
}

class _SelectUSerState extends State<SelectUSer> {
  var selected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Tell us! Who you are",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 20),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (selected !=
                    "patient") // Show Doctor option if not selected "patient"
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selected = "doctor"; // Set selected to "doctor"
                          });
                        },
                        radius: 75,
                        splashColor: Colors.white,
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.blue,
                          // Replace with primaryColor
                          child: Image.asset(
                            "lib/assets/icons/doctor.png",
                            height: 80,
                            width: 80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Doctor",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                    ],
                  ),
                if (selected !=
                    "doctor") // Show Patient option if not selected "doctor"
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selected = "patient"; // Set selected to "patient"
                          });
                        },
                        splashColor: Colors.white,
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: secondaryColor,
                          // Replace with secondaryColor
                          child: Image.asset(
                            "lib/assets/icons/patient.png",
                            height: 80,
                            width: 80,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Patient",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                if (selected == "patient"){
                  Get.to(PatientRegistration());
                }else{
                  Get.to(const DoctorRegistration()) ;
                }


              },
              style: ElevatedButton.styleFrom(primary: secondaryColor),
              child: const Text(
                "Get Started",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}

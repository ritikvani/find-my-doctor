import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmydoctor/stateManagement/getx_file.dart';
import 'package:findmydoctor/utility/common_button.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void customBottomSheet(
    context, nameController, emailController, phoneController, {required doctorDetails}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? userToken = sharedPreferences.getString("token");


  final userData = Get.put(CustomStates(userToken: userToken));
  userData.getAllData();

  print(" this is user data i am getting from state $userData");
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: 400,
          child: Column(children: [
            customTextField(
                labelText: "Your Name",
                hintText: "",
                defaultValue: userData.userDetails["Name"] ?? "",
                isEditable: false,
                controller: nameController),
            customTextField(
                labelText: "Your Email",
                hintText: "",
                defaultValue: userData.userDetails["Email"] ?? "",
                isEditable: false,
                controller: emailController),
            customTextField(
                labelText: "Your Phone Number",
                hintText: "",
                defaultValue: userData.userDetails["Phone"] ?? "",
                isEditable: false,
                controller: phoneController),
            SizedBox(
              height: 20,
            ),
            CommonButton(
                buttonText: "Book Now",
                backgroundColor: const Color(0xff2260FF),
                onPressed: () {
                  addAppointment(userToken , doctorDetails);
                },
                textColor: Color(0xffFFFFFF)),
          ]),
        );
      });

}
Future<void> addAppointment(userToken , doctorDetails) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var result = await firebaseFirestore
      .collection("registeredPatients")
      .doc(userToken)
      .collection("Appointments")
      .add(doctorDetails);
  print("result is $result") ;
}
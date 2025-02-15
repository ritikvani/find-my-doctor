import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmydoctor/stateManagement/getx_file.dart';
import 'package:findmydoctor/utility/common_button.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void customBottomSheet(
    context, TextEditingController nameController, TextEditingController emailController, TextEditingController phoneController,
    {required Map<String, dynamic> doctorDetails}) async {

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? userToken = sharedPreferences.getString("token");

  final userData = Get.put(CustomStates(userToken: userToken));

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  print("User Data from State: $userData");

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true, // Allows keyboard to adjust layout
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          Future<void> _selectDate(BuildContext context) async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              setState(() {
                selectedDate = picked;
              });
            }
          }

          Future<void> _selectTime(BuildContext context) async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              setState(() {
                selectedTime = picked;
              });
            }
          }

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                  labelText: "Your Name",
                  hintText: "",
                  defaultValue: userData.userDetails["Name"] ?? "",
                  isEditable: false,
                  controller: nameController,
                ),
                customTextField(
                  labelText: "Your Email",
                  hintText: "",
                  defaultValue: userData.userDetails["Email"] ?? "",
                  isEditable: false,
                  controller: emailController,
                ),
                customTextField(
                  labelText: "Your Phone Number",
                  hintText: "",
                  defaultValue: userData.userDetails["Phone"] ?? "",
                  isEditable: false,
                  controller: phoneController,
                ),
                const SizedBox(height: 10),

                // Date Picker
                ListTile(
                  title: Text(
                    selectedDate == null
                        ? "Select Date"
                        : "Selected Date: ${selectedDate!.toLocal()}".split(' ')[0],
                  ),
                  trailing: const Icon(Icons.calendar_today, color: Colors.blue),
                  onTap: () => _selectDate(context),
                ),

                // Time Picker
                ListTile(
                  title: Text(
                    selectedTime == null
                        ? "Select Time"
                        : "Selected Time: ${selectedTime!.format(context)}",
                  ),
                  trailing: const Icon(Icons.access_time, color: Colors.blue),
                  onTap: () => _selectTime(context),
                ),

                const SizedBox(height: 10),
                CommonButton(
                  buttonText: "Book Now",
                  backgroundColor: const Color(0xff2260FF),
                  onPressed: () {
                    if (selectedDate != null && selectedTime != null) {
                      // Combine selected date & time
                      DateTime appointmentDateTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      );

                      Map<String, dynamic> appointmentDetails = {
                        ...doctorDetails,
                        "appointmentDateTime": appointmentDateTime.toIso8601String(),
                      };

                      addAppointment(userToken, appointmentDetails);
                      Navigator.pop(context);
                    } else {
                      Get.snackbar("Error", "Please select a date and time");
                    }
                  },
                  textColor: Colors.white,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Future<void> addAppointment(String? userToken, Map<String, dynamic> doctorDetails) async {
  if (userToken == null) return;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var result = await firebaseFirestore
      .collection("registeredPatients")
      .doc(userToken)
      .collection("Appointments")
      .add(doctorDetails);

  print("Appointment booked successfully: $result");
}

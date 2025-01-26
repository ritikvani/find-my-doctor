import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_functions.dart';
import 'package:findmydoctor/utility/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PatientRegistration extends StatefulWidget {
  const PatientRegistration({Key? key}) : super(key: key);

  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController specializationController =
  TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController clinicAddressController = TextEditingController();
  final TextEditingController feesController = TextEditingController();
  final TextEditingController illnessController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? _image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        surfaceTintColor: secondaryColor,
        elevation: 0,
        title: const Text(
          "Register & Connect with Doctors",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                customTextField(labelText: "Name", hintText: "Enter your full name", controller: nameController),
                customTextField(labelText: "Age", hintText: "Enter your age (in years)", controller: ageController),
                customTextField(labelText: "Email", hintText: "Enter your email address", controller: emailController),
                customTextField(labelText: "Phone", hintText: "Enter your phone number", controller: phoneController),
                customTextField(labelText: "Gender", hintText: "Enter your gender (male, female or others)", controller: genderController),
                customTextField(labelText: "Address", hintText: "Enter your full address", controller: addressController),
                customTextField(labelText: "City", hintText: "Enter your city", controller: cityController),
                customTextField(labelText: "Medical Illness", hintText: "Tell us about medical illness", controller: illnessController),
                customTextField(labelText: "Password", hintText: "Create a password", controller: passwordController),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: handleSubmit,
                  child: const Text("Save"),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
  void handleSubmit() async {
    final Map<String, String> formData = {
      "Name": nameController.text,
      "Age": ageController.text,
      "Email": emailController.text,
      "Phone": phoneController.text,
      "Gender": genderController.text,
      "Address": addressController.text,
      "City": cityController.text,
      "Medical illness" : illnessController.text,
    };


    await handleSubmitForm(formData,emailController.text, passwordController.text);
    FocusScope.of(context).unfocus();
  }

  Future<void> chooseImage() async {
    try {
      ImagePicker picker = ImagePicker();
      final XFile? pickedImage =
      await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
        // print("Image picked: ${image.path}");
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
}

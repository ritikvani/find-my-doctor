import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_functions.dart';
import 'package:findmydoctor/utility/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({Key? key}) : super(key: key);

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
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
          "Register & Connect with Patients",
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
                customTextField(labelText: "Specialization", hintText: "Enter your specialization", controller: specializationController),
                customTextField(labelText: "Experience", hintText: "Enter your experience (in years)", controller: experienceController),
                customTextField(labelText: "Highest Degree/Qualification", hintText: "Enter your educational qualification", controller: qualificationController),
                customTextField(labelText: "Clinic Address", hintText: "Enter your clinic address (if available)", controller: clinicAddressController),
                customTextField(labelText: "Consultation Fees", hintText: "Enter your consultation fees (in rupees)", controller: feesController),
                customTextField(labelText: "Password", hintText: "Create a password", controller: passwordController),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: InkWell(
                    onTap: chooseImage,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _image == null
                            ? Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.grey[600],
                        )
                            : Image.file(
                          _image!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Upload Profile\nPicture",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: handleSubmit,
                  child: const Text("Submit"),
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
      "Specialization": specializationController.text,
      "Experience": experienceController.text,
      "Qualification": qualificationController.text,
      "Clinic Address": clinicAddressController.text,
      "Consultation Fees": feesController.text,
    };
    await handleSubmitForm(formData, emailController.text , passwordController.text);
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

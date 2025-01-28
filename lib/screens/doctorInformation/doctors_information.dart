import 'package:findmydoctor/screens/doctorInformation/utility/custom_bottomsheet.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorsInformation extends StatelessWidget {
  const DoctorsInformation(
      {Key? key,
      required this.doctorName,
      required this.doctorCategory,
      required this.consultationFees,
      required this.email,
      required this.clinicAddress,
      required this.gender,
      required this.phoneNumber,
      required this.city})
      : super(key: key);

  final String doctorName;
  final String doctorCategory;
  final String consultationFees;
  final String email;
  final String clinicAddress;
  final String gender;
  final String phoneNumber;
  final String city;

  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final Map<String, dynamic> doctorDetails = {
      "doctorName": doctorName,
      "doctorEmail": email,
      "doctorClinicAddress": clinicAddress,
      "doctorPhoneNumber": phoneNumber,
      "clinicAddress": clinicAddress
    };
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: primaryColor,
            )),
        centerTitle: true,
        title: Text(
          "Doctor Info",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: primaryColor),
        ),
        backgroundColor: secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRect(
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                          getFirstLetterOfName(doctorName),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: primaryColor),
                        ),
                        Text(
                          doctorCategory,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: primaryColor.withOpacity(0.7)),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 5),
                Divider(
                  color: primaryColor.withOpacity(0.5),
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                _buildInfoRow(Icons.email, email, "Email not provided"),
                _buildInfoRow(Icons.location_on, clinicAddress,
                    "Clinic address not available"),
                _buildInfoRow(Icons.person, gender, "Gender not specified"),
                _buildInfoRow(
                    Icons.phone, phoneNumber, "Phone number not available"),
                _buildInfoRow(Icons.location_city, city, "City not available"),
                _buildInfoRow(Icons.monetization_on, "$consultationFees/-",
                    "Consultation fees not available"),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      customBottomSheet(context, fullNameController,
                          emailController, phoneController ,doctorDetails: doctorDetails);
                    },
                    child: Text("Book an Appointment"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String info, String placeholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              info.isNotEmpty ? info : placeholder,
              style: TextStyle(fontSize: 16, color: primaryColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

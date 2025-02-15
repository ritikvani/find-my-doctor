import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmydoctor/screens/doctorInformation/doctors_information.dart';
import 'package:findmydoctor/stateManagement/getx_file.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  final DoctorController doctorController = Get.put(DoctorController());

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Obx(() {
        if (doctorController.doctors.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: doctorController.doctors.length,
          itemBuilder: (context, index) {
            final currentDoctor = doctorController.doctors[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () => Get.to(DoctorsInformation(
                  doctorName: currentDoctor['Name'],
                  doctorCategory: currentDoctor["Specialization"],
                  consultationFees: currentDoctor["Consultation Fees"],
                  clinicAddress: currentDoctor["Clinic Address"],
                  gender: currentDoctor["Gender"],
                  email: currentDoctor["Email"],
                  phoneNumber: currentDoctor["Phone"],
                  city: currentDoctor["City"],
                )),
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Text(
                          getFirstLetterOfName(currentDoctor['Name'] ?? ""),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    currentDoctor['Name'] ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    currentDoctor["Specialization"] ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: secondaryColor,
                                child: Text(
                                  "${currentDoctor["Experience"] ?? ""}+",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

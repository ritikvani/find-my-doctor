// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmydoctor/screens/doctorInformation/doctors_information.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/common_colors.dart';
class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  void initState() {
    super.initState();
    getAllDoctorsList();
  }

  List<Map<String, dynamic>> doctors = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: doctors.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final currentDoctor = doctors[index];

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () => Get.to(DoctorsInformation(
                      doctorName: currentDoctor['Name'],
                      doctorCategory: currentDoctor["Specialization"],
                        consultationFees : currentDoctor["Consultation Fees"],
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
                        color:
                            secondaryColor, // Replace with your 'secondaryColor'
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
                                  fontSize: 20),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Adds space between avatar and text
                          Expanded(
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: secondaryColor,
                                    child: Text(
                                      currentDoctor["Experience"] + "+" ?? "",
                                      // If experience is null, fallback to an empty string
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
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> getAllDoctorsList() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch the data from the 'all_doctors' collection.
      QuerySnapshot querySnapshot =
          await firestore.collection("allRegisteredDoctors").get();

      // Extract and print the documents.
      doctors = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
      // print( "this is  all doctors ${doctors}");
      setState(() {});
    } catch (e) {
      // Handle and print any errors.
      print("Error fetching data: $e");
    }
  }
}

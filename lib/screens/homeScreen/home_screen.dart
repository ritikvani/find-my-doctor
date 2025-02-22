import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmydoctor/screens/homeScreen/components/doctors_list.dart';
import 'package:findmydoctor/screens/login/login_screen.dart';
import 'package:findmydoctor/screens/patientScreens/appointment_screen.dart';
import 'package:findmydoctor/screens/profile/user_profile.dart';
import 'package:findmydoctor/screens/userModule/doctor/dashboard_screen.dart';
import 'package:findmydoctor/screens/userModule/utility/custom_darwer.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:findmydoctor/utility/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../stateManagement/getx_file.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userToken}) : super(key: key);
  final String userToken;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Map<String, dynamic> userDetails = {};
  final DoctorController doctorController = Get.put(DoctorController());
  late final CustomStates userData;
  var userDetails;
  bool? isUserPatient;

  @override
  void initState() {
    super.initState();
    getUserType();
    userData = Get.put(CustomStates(userToken: widget.userToken));
    doctorController.getAllDoctorsList();
    userDetails = userData;
    userData.getAllData();
  }

  void getUserType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() => {isUserPatient = sharedPreferences.getBool("isPatient")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: customDrawer(context , userDetails),
      appBar: AppBar(
        title: Text(isUserPatient! ? "patient" : "doctor"),
      ),
      body: SafeArea(
        child: Obx(
          () {
            return Center(
              child: userDetails.userDetails.isEmpty
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: LoadingAnimationWidget.newtonCradle(
                          color: Colors.white,
                          size: 150,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: secondaryColor,
                                    child: Text(
                                      getFirstLetterOfName(
                                          userDetails.userDetails["Name"]),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 25,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hi, WelcomeBack",
                                        style: TextStyle(
                                            color: primaryColor, fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        userDetails.userDetails["Name"],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundColor: secondaryColor,
                                      child: Image.asset(
                                        "lib/assets/icons/alert.png",
                                        width: 20,
                                        height: 20,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundColor: secondaryColor,
                                      child: Image.asset(
                                        "lib/assets/icons/setting.png",
                                        width: 20,
                                        height: 20,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 80,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomComponent(
                                      "Doctors",
                                      "lib/assets/icons/sthesthescope.png",
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    CustomComponent(
                                      "Favourite",
                                      "lib/assets/icons/heart.png",
                                    ),
                                    const Spacer(),
                                    customTextField(context)
                                  ],
                                ),
                              ),
                              const DoctorsList(),
                            ],
                          ),
                        )
                      ]),
                    ),
            );
          },
        ),
      ),
    );
  }

  // Drawer customDrawer(BuildContext context ) {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: [
  //         // User Profile Header
  //         UserAccountsDrawerHeader(
  //           accountName:
  //               Text(userDetails.userDetails["Name"] ?? "Not available"),
  //           accountEmail:
  //               Text(userDetails.userDetails["Email"] ?? "Not available"),
  //           currentAccountPicture: CircleAvatar(
  //             backgroundImage:
  //                 const NetworkImage('https://example.com/profile-picture.jpg'),
  //             // Replace with a valid URL or asset
  //             child: Text(
  //               getFirstLetterOfName(userDetails.userDetails["Name"] ?? ""),
  //               // Fallback initial
  //               style: const TextStyle(fontSize: 24, color: Colors.white),
  //             ),
  //           ),
  //           decoration: const BoxDecoration(
  //             color: Colors.blue,
  //             image: DecorationImage(
  //               image: NetworkImage(
  //                 'https://example.com/background-image.jpg', // Optional background image
  //               ),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //
  //         // Drawer Items
  //         ListTile(
  //           leading: const Icon(Icons.person),
  //           title: const Text('Profile'),
  //           onTap: () {
  //             Get.to(() => UserProfile()); // Close the drawer
  //           },
  //         ),
  //         ListTile(
  //           leading: const Icon(Icons.medical_services),
  //           title: const Text('My Appointments'),
  //           onTap: () {
  //             Get.to(() => const AppointmentScreen()); // Close the drawer
  //           },
  //         ),
  //
  //         ListTile(
  //           leading: const Icon(Icons.settings),
  //           title: const Text('Settings'),
  //           onTap: () {
  //             Navigator.pop(context); // Close the drawer
  //           },
  //         ),
  //         ListTile(
  //           leading: const Icon(Icons.logout),
  //           title: const Text('Logout'),
  //           onTap: () {
  //             Get.offAll(const LoginScreen());
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  customTextField(context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width *
          0.5, // Use double.infinity for better readability
      child: TextField(
        // onChanged: (value) {
        //   _filterSearchResults(value)
        // },
        decoration: InputDecoration(
          hintText: "Search here...",
          suffixIcon: Image.asset(
            "lib/assets/icons/search.png",
            scale: 3,
          ),
          filled: true,
          fillColor: secondaryColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15), // Adjust padding for better alignment
        ),
      ),
    );
  }

  // void _filterSearchResults(String query) {
  //   if (query.isEmpty) {
  //     return;
  //   } else {
  //     setState(() {
  //       allDoctors = userData.where((item) => item.toLowerCase().contains(query.toLowerCase()))
  //           .toList();
  //     });
  //   }
  // }

  Column CustomComponent(String customLabel, String imageUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
          width: 25,
          height: 25,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 5),
        Text(
          customLabel,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: primaryColor),
        )
      ],
    );
  }
//
// Future<void> getAllData() async {
//   try {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     var userData = await firestore
//         .collection("registeredPatients")
//         .doc(widget.userToken)
//         .get();
//     print("${userData.data()} this is your data ");
//
//     setState(() => {userDetails = userData.data()!});
//   } catch (e) {
//     // Handle and print any errors.
//     print("Error fetching data: $e");
//   }
// }
}

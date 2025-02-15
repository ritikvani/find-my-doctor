import 'package:findmydoctor/screens/login/login_screen.dart';
import 'package:findmydoctor/screens/patientScreens/appointment_screen.dart';
import 'package:findmydoctor/utility/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Drawer customDrawer(BuildContext context, userDetails) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // User Profile Header
        UserAccountsDrawerHeader(
          accountName:
          Text(userDetails.userDetails["Name"] ?? "Not available"),
          accountEmail:
          Text(userDetails.userDetails["Email"] ?? "Not available"),
          currentAccountPicture: CircleAvatar(
            backgroundImage:
            const NetworkImage('https://example.com/profile-picture.jpg'),
            // Replace with a valid URL or asset
            child: Text(
              getFirstLetterOfName(userDetails.userDetails["Name"] ?? ""),
              // Fallback initial
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: NetworkImage(
                'https://example.com/background-image.jpg', // Optional background image
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Drawer Items
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          // onTap: () {
          //   Get.to(() => UserProfile()); // Close the drawer
          // },
        ),
        ListTile(
          leading: const Icon(Icons.medical_services),
          title: const Text('My Appointments'),
          onTap: () {
            Get.to(() => const AppointmentScreen()); // Close the drawer
          },
        ),

        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            Get.offAll(const LoginScreen());
          },
        ),
      ],
    ),
  );
}
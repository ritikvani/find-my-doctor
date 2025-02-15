import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CustomStates extends GetxController {
  CustomStates({required this.userToken});

  String? userToken;

  var userDetails = {}.obs; // Reactive variable for user details
  RxList<Map<String, dynamic>> doctors = <Map<String, dynamic>>[].obs; // Reactive list for doctors

  // Fetch user data based on the user token
  Future<void> getAllData() async {
    try {
      if (userToken == null || userToken!.isEmpty) {
        throw Exception("User token is not set.");
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var userData = await firestore
          .collection("registeredPatients")
          .doc(userToken)
          .get();

      if (userData.exists) {
        userDetails.value = userData.data() ?? {};
        print("${userDetails.value} this is your data ");
      } else {
        print("No data found for this token.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  // Fetch all doctors from the Firestore
  Future<void> getAllDoctorsList() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch the data from the 'allRegisteredDoctors' collection
      QuerySnapshot querySnapshot =
      await firestore.collection("allRegisteredDoctors").get();

      // Extract and assign the data to the reactive list
      doctors.value = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print("This is all doctors: $doctors");

      // Since we are using GetX, you do not need setState().
      // The list will be updated reactively in the UI.
    } catch (e) {
      // Handle and print any errors.
      print("Error fetching data: $e");
    }
  }
}
class DoctorController extends GetxController {
  var doctors = <Map<String, dynamic>>[].obs;

  Future<void> getAllDoctorsList() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch the data from Firestore
      QuerySnapshot querySnapshot =
      await firestore.collection("allRegisteredDoctors").get();

      // Convert documents to a list
      doctors.value = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      print("This is all doctors: $doctors");
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}

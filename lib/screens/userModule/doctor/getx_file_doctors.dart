import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DoctorDetails extends GetxController {
  DoctorDetails({required this.userToken});

  String? userToken;

  var userDetails = {}.obs;
  RxList<Map<String, dynamic>> doctors = <Map<String, dynamic>>[].obs;

  // Fetch user data based on the user token
  Future<void> getUserData() async {
    try {
      if (userToken == null || userToken!.isEmpty) {
        throw Exception("User token is not set.");
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var userData = await firestore
          .collection("allRegisteredDoctors")
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

}
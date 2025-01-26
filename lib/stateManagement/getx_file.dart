import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CustomStates extends GetxController {
  CustomStates({ required this.userToken});

  String? userToken;


  var userDetails = {}.obs;

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
    }
    catch (e) {
      print("Error fetching data: $e");
    }
  }
}

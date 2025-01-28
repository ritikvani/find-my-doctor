import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../screens/login/login_screen.dart';

Future<void> handleSubmitForm(
    Map<String, dynamic> userDetails, String email, var password, String user) async {
  try {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    // Create a user with FirebaseAuth
    var response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    String? uniqueKey = response.user?.uid;

    // Determine the collection based on the user type
    String collectionName =
    user == "patient" ? "registeredPatients" : "allRegisteredDoctors";

    // Add user details to the appropriate Firestore collection
    await fireStore.collection(collectionName).doc(uniqueKey).set(userDetails).then((_) {
      Get.to(LoginScreen());
    });

    print("Data successfully added to Firestore!");

  } catch (error) {
    print("Error in storing the data: ${error.toString()}");
  }
}


getFirstLetterOfName(String name) {
  if (name.isEmpty) {
    return ""; // Return empty string or a fallback value
  }
  List<String> subStrings = name.split(" ");
  String initials = subStrings.map((text) => text[0]).join().toUpperCase();
  return initials;
  print(initials);
}

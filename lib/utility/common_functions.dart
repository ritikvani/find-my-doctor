import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../screens/login/login_screen.dart';

Future<void> handleSubmitForm(
    Map<String, dynamic> userDetails, String email, var password) async {
  try {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    var response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    String? uniqueKey = response.user?.uid;
    await fireStore
        .collection("registeredPatients")
        .doc(uniqueKey)
        .set(userDetails).then((e) => Get.to(LoginScreen()));

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

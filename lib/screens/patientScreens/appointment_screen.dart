import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmydoctor/utility/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<Map<String, dynamic>> myAppointments = [];
  bool loading = false;

  @override
  initState() {
    super.initState();
    getAllAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        surfaceTintColor: secondaryColor,
        elevation: 0,
        title: const Text(
          "My Appointments",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: loading
          ?    Center(
        child:LoadingAnimationWidget.newtonCradle(
          color: Colors.white,
          size: 150,
        ),

    )
          : myAppointments.isEmpty
          ? const Center(
        child: Text(
          "No Appointments Found",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: myAppointments.length,
          itemBuilder: (context, index) {
            var appointment = myAppointments[index];
            return AppointmentCard(appointment: appointment);
          },
        ),
      ),
    );
  }

  Future getAllAppointments() async {
    setState(() {
      loading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    try {
      if (token == null || token.isEmpty) {
        throw Exception("User token is not set.");
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var userData = await firestore
          .collection("registeredPatients")
          .doc(token)
          .collection("Appointments")
          .get();

      setState(() {
        loading = false;
        myAppointments =
            userData.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print("Error fetching data: $e");
    }
  }
}


class AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment['doctorName'] ?? "Unknown Doctor",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    appointment['clinicAddress'] ?? "No Address",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text(
                  appointment['doctorPhoneNumber'] ?? "No Phone Number",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text(
                  appointment['doctorEmail'] ?? "No Email",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

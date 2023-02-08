import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musayi/screens/adminscreens/approving_page.dart';

// Class for creating the admin home screen 
class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

// Stateful class for the admin home screen
class _AdminHomeState extends State<AdminHome> {
  // Stream of data from the blood requests collection in Firestore
  final Stream<QuerySnapshot> requestsStream =
      FirebaseFirestore.instance.collection('bloodRequest').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: requestsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Error handling
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          // Loading indication
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              // Map of the document data
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ListTile(
                  // Rounded rectangle border for the list tile
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  // Background color of the list tile
                  tileColor: Colors.green[200],
                  // Title text of the list tile
                  title: RichText(
                      text: TextSpan(
                          text: "Location: ${data['location']} \n",
                          style: const TextStyle(color: Colors.black),
                          children: [
                        TextSpan(text: "BloodAmount: ${data['blood_amount']}")
                      ])),
                  // Subtitle text of the list tile
                  subtitle: RichText(
                      text: TextSpan(
                          text: "BloodGroup: ${data['blood_group']} \n",
                          style: const TextStyle(color: Colors.black),
                          children: [
                        TextSpan(text: "Date of Need: ${data['Date_of_Need']}")
                      ])),
                  // Trailing chip with the status of the request
                  trailing: Chip(label: Text(data['status'])),
                  // On tap action
                  onTap: () {
                    print(
                        "${FirebaseFirestore.instance.collection('bloodRequest').doc(document.id)}");
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: ((context) => ApprovingPage(
                                  document: document,
                                  location: data['location'],
                                  bloodAmount: data['blood_amount'],
                                  tel: data['tel'],
                                  group: data['blood_group'],
                                  date: data['Date_of_Need'],
                                ))),
                        (route) => true);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

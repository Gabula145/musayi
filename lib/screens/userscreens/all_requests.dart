import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

// Class _RequestsState extends the State widget and implements the build method to render the UI
class _RequestsState extends State<Requests> {
  // Stream to get the blood request data from Firestore
  final Stream<QuerySnapshot> requestsStream =
      FirebaseFirestore.instance.collection('bloodRequest').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title
      appBar: AppBar(
        title: Text("Blood Requests"),
      ),
      // Body of the screen with StreamBuilder widget
      body: StreamBuilder<QuerySnapshot>(
        // Assign the stream of blood requests
        stream: requestsStream,
        // Build the widget based on the stream data
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // If there is an error, display an error message
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }
          // If the stream is still loading, show a progress indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // If there are no blood requests available, show a message
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Blood Requests Available"),
            );
          }
          // If the data is available, build a list view with the data
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              // Get the data from the document
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                // Add padding to each list tile
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ListTile(
                  // Add a rounded border to the list tile
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  // Set the background color of the list tile
                  tileColor: Colors.green[200],
                  // Set the title with location and blood amount
                  title: RichText(
                      text: TextSpan(
                          text: "Location: ${data['location']} \n",
                          style: const TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            text: "Blood Amount: ${data['blood_amount']} mL")
                      ])),
                  // Set the subtitle with blood group and date of need
                  subtitle: RichText(
                      text: TextSpan(
                          text: "Blood Group: ${data['blood_group']} \n",
                          style: const TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            text: "Date of Need: ${data['Date_of_Need']}")
                      ])),
                  trailing: Chip(label: Text(data['status'])),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

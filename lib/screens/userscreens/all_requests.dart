import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final Stream<QuerySnapshot> requestsStream =
      FirebaseFirestore.instance.collection('bloodRequest').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Requests"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: requestsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Blood Requests Available"),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  tileColor: Colors.green[200],
                  title: RichText(
                      text: TextSpan(
                          text: "Location: ${data['location']} \n",
                          style: const TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            text: "Blood Amount: ${data['blood_amount']} mL")
                      ])),
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

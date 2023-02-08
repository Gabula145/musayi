import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musayi/widgets/rounded_button.dart';

// StatefulWidget for displaying approved requests information
class ApprovingPage extends StatefulWidget {
// Data received from previous screen to display on the ApprovingPage
final DocumentSnapshot<Object?> document;
final String location;
final String bloodAmount;
final String tel;
final String group;
final String date;

// Constructor for ApprovingPage
const ApprovingPage(
{Key? key,
required this.document,
required this.location,
required this.bloodAmount,
required this.tel,
required this.group,
required this.date})
: super(key: key);

// Create the state for ApprovingPage
@override
State<ApprovingPage> createState() => _ApprovingPageState();
}

// State for ApprovingPage widget
class _ApprovingPageState extends State<ApprovingPage> {
// Instance of Firestore to store the request information
final requestDB = FirebaseFirestore.instance;

// Build the widget tree for ApprovingPage
@override
Widget build(BuildContext context) {
// Scaffold to define the basic structure of the page
return Scaffold(
appBar: AppBar(),
// Center widget to center the contents inside the body
body: Center(
child: Container(
// Set width to maximum
width: double.infinity,
// BoxDecoration for background color and border radius
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20), color: Colors.white),
child: Column(
children: [
// 1st
SizedBox(
// Set width to 90% of the screen width
width: MediaQuery.of(context).size.width * 0.9,
child: Card(
elevation: 10,
child: Column(children: [
Wrap(
children: [
// Label for location information
const Text(
"Location: ",
style: TextStyle(
fontSize: 18,
color: Colors.black,
fontWeight: FontWeight.bold),
),
// Display the location information
Text(
widget.location,
style: const TextStyle(
fontSize: 15,
color: Colors.black,
fontWeight: FontWeight.normal),
)
],
),
]),
),
),

              // 2nd
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  elevation: 10,
                  child: Column(children: [
                    Wrap(
                      children: [
                        const Text(
                          "Blood Amount: ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.bloodAmount,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ]),
                ),
              ),

              // 3rd
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  elevation: 10,
                  child: Column(children: [
                    Wrap(
                      children: [
                        const Text(
                          "Phone: ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.tel,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ]),
                ),
              ),

              // 4TH
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  elevation: 10,
                  child: Column(children: [
                    Wrap(
                      children: [
                        const Text(
                          "Blood Group: ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.group,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ]),
                ),
              ),

              // 5th

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  elevation: 10,
                  child: Column(children: [
                    Wrap(
                      children: [
                        const Text(
                          "Date of Need: ",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.date,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ]),
                ),
              ),

              RoundedButton(
                  text: "Approve",
                  press: () {
                    requestDB
                        .collection('bloodRequest')
                        .doc(widget.document.id)
                        .update({'status': 'approved'})
                        .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text("Client approved successfully"))))
                        .catchError((error) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content:
                                    Text("Failed to update user: $error"))));
                  },
                  color: const Color.fromARGB(255, 76, 143, 197))
            ],
          ),
        ),
      ),
    );
  }
}

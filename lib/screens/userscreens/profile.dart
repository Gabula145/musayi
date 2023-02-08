import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musayi/authgate.dart';
import 'package:musayi/widgets/rounded_button.dart';

import '../../widgets/profile_tile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Instance of FirebaseAuth to handle user sign-in and sign-out
  FirebaseAuth signedin = FirebaseAuth.instance;
  FirebaseAuth signout = FirebaseAuth.instance;

  // Function to sign out the user
  signingout() async {
    // Sign out the user using the instance of FirebaseAuth
    await signout.signOut();
  }

  // List to store user data
  List user = [    {"name": "Email", "text": "${FirebaseAuth.instance.currentUser!.email}"},  ];

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // Set the background color
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(children: [
          //top card
          Transform.rotate(
            // Rotate the top card
            angle: (60 / 180),
            origin: Offset(size.width * 2.4, size.height * -0.1),
            child: Container(
              // Add padding to the container
              padding: const EdgeInsets.all(20),
              // Set the height and width of the container
              height: size.height * 0.65,
              width: size.height * 0.65,
              // Add a red background color and a border radius to the container
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(200),
                ),
              ),
            ),
          ),
          Positioned(
            // Position the content of the screen
            left: 0,
            top: size.height * 0.003,
            right: 0,
            child: Padding(
              // Add padding to the content
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  // Use a SingleChildScrollView to make the content scrollable
                  child: Column(
                    children: [
                      PhysicalModel(
                        color: Colors.transparent,
                        // Set the color of the PhysicalModel to transparent
                        borderRadius: BorderRadius.circular(200),
                        // Set the border radius of the PhysicalModel
                        clipBehavior: Clip.antiAlias,
                        elevation: 10,
                        child: CircleAvatar(
                          // Display the user's profile picture
                          radius: 80,
                          backgroundColor: Colors.red[100],
                          foregroundImage:
                              const AssetImage("assets/images/demoLogo.png"),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "User: ${signedin.currentUser!.email.toString()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Column(
                        children: List.generate(
                          user.length,
                          (index) => ProfileTile(
                              padding: 20,
                              label: user[index]['name'],
                              value: user[index]['text']),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size.height * 0.5,
            child: RoundedButton(
                text: "SignOut",
                press: () {
                  signingout();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: ((context) => const AuthGate())),
                      (route) => true);
                },
                color: Colors.red),
          )
        ]),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:musayi/screens/adminscreens/login.dart';
import 'package:musayi/screens/userscreens/index.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the data has not yet loaded into the snapshot, show the sign in screen
        if (!snapshot.hasData) {
          return SignInScreen(
            // Show the switch to toggle between sign in and sign up modes
            showAuthActionSwitch: true,
            headerBuilder: (context, constraints, _) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Display the heartbeat image
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset("assets/images/heartbeat.png"),
                    ),
                    // Add space between the image and the menu icon
                    const Spacer(),
                    IconButton(
                        // Navigate to the login page when the menu icon is pressed
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: ((context) => Login())),
                              (route) => true);
                        },
                        icon: const Icon(Icons.menu_outlined))
                  ],
                ),
              );
            },
            // Display the appropriate subtitle for the sign in/sign up mode
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? 'Welcome to the Musayi app! Please sign in to continue.'
                      : 'Welcome to Musayi app! Please create an account to continue',
                ),
              );
            },
            // Add a footer with the terms and conditions
            footerBuilder: (context, _) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions of our Musayi app services.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            // Use the email provider for authentication
            providerConfigs: const [
              EmailProviderConfiguration(),
            ],
          );
        }
        // If the user is already signed in, go to the index page
        return Index();
      },
    ));
  }
}

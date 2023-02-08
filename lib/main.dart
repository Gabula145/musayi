import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musayi/authgate.dart';
import 'firebase_options.dart';

void main() async {
  // Initialize the WidgetsBinding, so that the framework can be initialized.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the Firebase app using the `FirebaseOptions` defined in `firebase_options.dart`
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Start the app by calling the `runApp` function, passing it a `MyApp` widget.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Define a constant constructor, so that the widget can be created using `const`.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the title of the application.
      title: 'Musayi',
      // Set the theme of the application.
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // Hide the debug banner (the banner that appears in the top right corner
      // of the screen during development, indicating the current mode).
      debugShowCheckedModeBanner: false,
      // Set the home screen of the application to be the `AuthGate` widget.
      home: const AuthGate(),
    );
  }
}

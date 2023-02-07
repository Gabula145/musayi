import 'package:flutter/material.dart';
import 'package:musayi/constants/color_pallete.dart';
import 'package:musayi/screens/adminscreens/admin_home.dart';
import 'package:musayi/widgets/rounded_button.dart';
import 'package:musayi/widgets/rounded_input_field.dart';
import 'package:musayi/widgets/rounded_password_field.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _autovalidate = false;

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AdminHome()),
          (route) => false);
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                const Text(
                  "Admin Log in",
                  textHeightBehavior: TextHeightBehavior(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Icon(
                  Icons.verified_user_rounded,
                  size: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  icon: Icons.mail_outline_rounded,
                  controller: emailController,
                  hintText: "Your Email",
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Email is required";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                  autovalidate: _autovalidate,
                ),
                RoundedPassword

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  Uint8List? file;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: mobileBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                // logo image
                Image.asset(
                  "assets/logo.png",
                  height: 60,
                  color: primaryColor,
                ),
                const SizedBox(
                  height: 40,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 60,
                      child: IconButton(
                        onPressed: () {},
                        icon:
                            const Icon(Icons.add_a_photo, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),

                // text field for email
                TextFiledWidget(
                  obscure: false,
                  hintText: "Email",
                  inputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),

                const SizedBox(
                  height: 23,
                ),

                //text field for full name
                TextFiledWidget(
                  obscure: false,
                  hintText: "Enter Full name",
                  inputType: TextInputType.name,
                  controller: _fullNameController,
                ),

                const SizedBox(
                  height: 23,
                ),
                // text field for username
                TextFiledWidget(
                  obscure: false,
                  hintText: "Enter username",
                  inputType: TextInputType.name,
                  controller: _usernameController,
                ),

                const SizedBox(
                  height: 23,
                ),
                //text field for password
                TextFiledWidget(
                  obscure: true,
                  hintText: "Password",
                  inputType: TextInputType.text,
                  controller: _passwordController,
                ),

                const SizedBox(
                  height: 23,
                ),

                // button login
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Auth().signUp(
                      _emailController.text,
                      _passwordController.text,
                      _fullNameController.text,
                      _usernameController.text,
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Registered?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Log in.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                // text button for signing up
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

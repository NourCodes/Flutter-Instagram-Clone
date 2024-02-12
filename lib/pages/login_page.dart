import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackground,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),

              // logo image
              Image.asset("assets/logo.png", height: 64, color: Colors.white),
              const SizedBox(
                height: 60,
              ),

              // text field for email
              TextFiledWidget(
                obscure: false,
                hintText: "Username or email",
                inputType: TextInputType.emailAddress,
                controller: _emailController,
              ),

              const SizedBox(
                height: 15,
              ),

              //text field for password
              TextFiledWidget(
                obscure: true,
                hintText: "Password",
                inputType: TextInputType.text,
                controller: _passwordController,
              ),

              const SizedBox(
                height: 20,
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
                onPressed: () {},
                child: const Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 20),
                      child: const Divider(
                        height: 30,
                      ),
                    ),
                  ),
                  const Text("OR"),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                        left: 20,
                      ),
                      child: const Divider(
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // text button for signing up
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sign up.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

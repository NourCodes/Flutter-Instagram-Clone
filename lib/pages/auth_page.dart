import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/pages/login_page.dart';
import 'package:instagram_clone/pages/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;

  toggleScreen() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    //by default it will show login page
    if (showLogin) {
      return LoginPage(
        screen: toggleScreen,
      );
    } else {
      return SignupPage(
        screen: toggleScreen,
      );
    }
  }
}

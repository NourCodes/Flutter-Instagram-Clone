import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/user_model.dart';
import 'package:instagram_clone/pages/login_page.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/utilities/colors.dart';
import '../responsive_layout/mobile_layout.dart';
import '../responsive_layout/screen_layout_adaptor.dart';
import '../responsive_layout/web_layout.dart';

class AuthStateWrapper extends StatefulWidget {
  const AuthStateWrapper({Key? key}) : super(key: key);

  @override
  State<AuthStateWrapper> createState() => _AuthStateWrapperState();
}

class _AuthStateWrapperState extends State<AuthStateWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: Auth().users,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const ScreenLayoutAdaptor(
              mobileScreen: MobileScreen(),
              webScreen: WebScreen(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.hasError}"),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }
        return const LoginPage();
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive_layout/mobile_layout.dart';
import 'package:instagram_clone/responsive_layout/screen_layout_adaptor.dart';
import 'package:instagram_clone/responsive_layout/web_layout.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      ),
      home: const ScreenLayoutAdaptor(
        mobileScreen: MobileScreen(),
        webScreen: WebScreen(),
      ),
    );
  }
}

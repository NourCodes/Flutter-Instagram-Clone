import 'package:flutter/material.dart';

class ScreenLayoutAdaptor extends StatelessWidget {
  final Widget webScreen;
  final Widget mobileScreen;
  const ScreenLayoutAdaptor(
      {Key? key, required this.webScreen, required this.mobileScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          //web screen
          return webScreen;
        }
        //mobile screen
        return mobileScreen;
      },
    );
  }
}

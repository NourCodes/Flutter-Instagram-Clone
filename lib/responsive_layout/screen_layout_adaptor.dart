import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/userdata_provider.dart';
import 'package:provider/provider.dart';
import '../utilities/dimensions.dart';

class ScreenLayoutAdaptor extends StatefulWidget {
  final Widget webScreen;
  final Widget mobileScreen;
  const ScreenLayoutAdaptor(
      {Key? key, required this.webScreen, required this.mobileScreen})
      : super(key: key);

  @override
  State<ScreenLayoutAdaptor> createState() => _ScreenLayoutAdaptorState();
}

class _ScreenLayoutAdaptorState extends State<ScreenLayoutAdaptor> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  void addData() async {
    UserDataProvider _userDataProvider = Provider.of(context, listen: false);
    await _userDataProvider.getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          //web screen
          return widget.webScreen;
        }
        //mobile screen
        return widget.mobileScreen;
      },
    );
  }
}

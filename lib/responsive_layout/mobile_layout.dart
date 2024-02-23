import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/userdata_provider.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/model/userdata_model.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDataModel userData = Provider.of<UserDataProvider>(context).getUserData;
    return Scaffold(
      body: Center(
        child: Text(userData.userName),
      ),
    );
  }
}

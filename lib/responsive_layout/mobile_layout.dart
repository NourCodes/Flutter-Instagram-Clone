import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/add_post_page.dart';
import 'package:instagram_clone/pages/profile_page.dart';
import 'package:instagram_clone/provider/userdata_provider.dart';
import 'package:instagram_clone/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:instagram_clone/model/userdata_model.dart';
import '../pages/home_page.dart';
import '../pages/like_page.dart';
import '../pages/search_page.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int _page = 0;
  void onTapped(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> lists = const [
    HomePage(),
    SearchPage(),
    AddPostPage(),
    LikePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // UserDataModel userData = Provider.of<UserDataProvider>(context).getUserData;

    return Scaffold(
      body: lists[_page],
      bottomNavigationBar: BottomNavBar(
        page: _page,
        onTapped: onTapped,
      ),
    );
  }
}

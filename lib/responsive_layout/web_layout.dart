import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/add_post_page.dart';
import '../pages/feed_page.dart';
import '../pages/like_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../services/auth.dart';
import '../services/data.dart';
import '../widgets/bottom_nav_bar.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  int _currentPageIndex = 0;

  List<Widget> lists = [
    const FeedPage(),
    const SearchPage(),
    const AddPostPage(),
    const LikePage(),
    ProfilePage(
      uid: Auth().currentUserId,
    ),
  ];
  void onTapped(int page) {
    setState(() {
      _currentPageIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lists[_currentPageIndex],
      bottomNavigationBar: BottomNavBar(
        page: _currentPageIndex,
        onTapped: onTapped,
      ),
    );
  }
}

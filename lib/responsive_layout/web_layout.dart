import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/colors.dart';
import '../pages/add_post_page.dart';
import '../pages/feed_page.dart';
import '../pages/like_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../services/auth.dart';

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
      appBar: AppBar(
        backgroundColor: mobileBackground,
        centerTitle: false,
        title: Image.asset(
          "assets/logo.png",
          height: 40,
          color: primaryColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              onTapped(0);
            },
            icon: Icon(
              Icons.home,
              color: _currentPageIndex == 0 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onTapped(1);
            },
            icon: Icon(
              Icons.search,
              color: _currentPageIndex == 1 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onTapped(2);
            },
            icon: Icon(
              Icons.add_circle,
              color: _currentPageIndex == 2 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onTapped(3);

            },
            icon: Icon(
              Icons.favorite,
              color: _currentPageIndex == 3 ? primaryColor : secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onTapped(4);
            },
            icon: Icon(
              Icons.person,
              color: _currentPageIndex == 4 ? primaryColor : secondaryColor,
            ),
          ),
        ],
      ),
      body: lists[_currentPageIndex],
    );
  }
}

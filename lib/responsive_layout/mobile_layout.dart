import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/add_post_page.dart';
import 'package:instagram_clone/pages/feed_page.dart';
import 'package:instagram_clone/pages/profile_page.dart';
import 'package:instagram_clone/widgets/bottom_nav_bar.dart';
import '../pages/like_page.dart';
import '../pages/search_page.dart';
import '../services/auth.dart';

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

  List<Widget> lists = [
    const FeedPage(),
    const SearchPage(),
    const AddPostPage(),
    const LikePage(),
    ProfilePage(
      uid: Auth().currentUserId,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lists[_page],
      bottomNavigationBar: BottomNavBar(
        page: _page,
        onTapped: onTapped,
      ),
    );
  }
}

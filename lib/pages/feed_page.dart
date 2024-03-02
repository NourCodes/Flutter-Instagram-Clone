import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/post_UI.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackground,
        title: Image.asset(
          'assets/logo.png',
          color: Colors.white,
          width: 100,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.messenger_outline,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const PostCard(
            profImage:
                "https://images.unsplash.com/photo-1569173112611-52a7cd38bea9?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            userImage:
                'https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            username: "Username",
          );
        },
      ),
    );
  }
}

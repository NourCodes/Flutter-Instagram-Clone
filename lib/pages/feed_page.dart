import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/dimensions.dart';
import 'package:instagram_clone/widgets/post_UI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/services/data.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: width > webScreenSize ? webBackground: mobileBackground,
      appBar: width > webScreenSize ? null: AppBar(
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: Data().getPost,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              throw Exception("An Error Occurred");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (!snapshot.hasData) {
              const Center(
                child: Text("No Posts Yet!"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                return Container(
                  margin:EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.3:0,
                    vertical: width > webScreenSize ? 15 :0,
                  ),
                  child: PostCard(
                    postId: data["postId"] ?? "",
                    profImage: data["profImage"] ??
                        "https://images.unsplash.com/photo-1569173112611-52a7cd38bea9?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    userImage: data["postUrl"] ??
                        'https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    username: data["username"] ?? "Username",
                    date: data["datePublished"] ?? DateTime.now(),
                    description: data["description"] ?? "This is the description",
                    likes: data["likes"] ?? [],
                  ),
                );
              },
            );
          }),
    );
  }
}
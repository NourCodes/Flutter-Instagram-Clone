import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/commentcard_UI.dart';
class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackground,
        title: const Text("Comments"),
        centerTitle: false,
      ),
      body: const CommentCard(),

      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Row(
            children: [
              const CircleAvatar(
              foregroundImage: NetworkImage('https://images.unsplash.com/photo-1579783483458-83d02161294e?q=80&w=1997&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              radius: 16,
            ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8.0),
                  child: TextField(
                
                    decoration: InputDecoration(
                      hintText: 'comment',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 8,
                  ),
                  child: const Text("Post", style: TextStyle(
                    color: blue,
                  ),),
                ),

              ),],
          ),
        ),
      ),

    );
  }
}

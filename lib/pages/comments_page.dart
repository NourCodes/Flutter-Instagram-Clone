import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/model/userdata_model.dart';
import 'package:instagram_clone/provider/userdata_provider.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/commentcard_UI.dart';
import 'package:provider/provider.dart';
import '../services/data.dart';

class CommentsPage extends StatefulWidget {
  final String postId;
  const CommentsPage({super.key, required this.postId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserDataModel userData =
        Provider.of<UserDataProvider>(context).getUserData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackground,
        title: const Text("Comments"),
        centerTitle: false,
      ),
      body: CommentCard(
        date: DateTime.now(),
        image: userData.imageUrl,
        description: _controller.text,
        username: userData.userName,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(userData.imageUrl) ??
                    NetworkImage(
                        'https://images.unsplash.com/photo-1579783483458-83d02161294e?q=80&w=1997&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                radius: 16,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'comment',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await Data().postComments(widget.postId, _controller.text,
                      userData.userName, userData.id, userData.imageUrl);
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 8,
                  ),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/model/userdata_model.dart';
import 'package:instagram_clone/provider/userdata_provider.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/commentcard_UI.dart';
import 'package:provider/provider.dart';
import '../services/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsPage extends StatefulWidget {
  final String postId;
  const CommentsPage({super.key, required this.postId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: Data().comments(widget.postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // while waiting for data, show a loading indicator
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // if an error occurs, display an error message
              return Text(
                'Error: ${snapshot.error}',
              );
            } else if (snapshot.data!.docs.isEmpty) {
              // if there are no documents in the snapshot, display a message
              return const Center(
                child: Text(
                  "No Comments Yet!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              // if data is available, display it
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index];
                  // convert Firestore Timestamp to DateTime
                  DateTime datePublished =
                      (data["datePublished"] as Timestamp).toDate();
                  return CommentCard(
                    date: datePublished,
                    image: data["profImage"],
                    description: data["description"],
                    username: data["username"],
                  );
                },
              );
            }
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(
                  userData.imageUrl,
                ),
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
                  await Data().postComments(
                    widget.postId,
                    _controller.text,
                    userData.userName,
                    userData.id,
                    userData.imageUrl,
                  );
                  setState(() {
                    _controller.text = "";
                  });
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

import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/add_post_page.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/follow_button.dart';
import '../services/data.dart';
import '../widgets/profile_column.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({
    super.key,
    required this.uid,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData = {};
  int numPosts = 0;
  bool isLoading = false;
  bool isFollowed = false;
  int followers = 0;
  int following = 0;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    var snap = await Data().getUserData(widget.uid);

    // check if the snapshot data is null
    if (snap.exists) {
      // retrieve data only if the snapshot exists
      var data = snap.data();
      // check if data is not null and is of type Map
      if (data != null) {
        numPosts = await Data().getNumberOfPosts(widget.uid);
        setState(() {
          isLoading = false;
          userData = data;
        });
      }
      isFollowed = userData["followers"].contains(Auth().currentUserId);
      followers = userData["followers"].length;
      following = userData["following"].length;
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator(),
    )
        : userData.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  // appBar with user's username as title
                  title: Text(
                    userData["username"],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: IconButton(
                        // button to navigate to AddPostPage
                        icon: const Icon(
                          Icons.add_box_outlined,
                          color: primaryColor,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddPostPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    // menu icon
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Icon(
                        Icons.menu,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                body: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : userData.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // user data display
                                    Row(
                                      children: [
                                        // profile picture
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              userData["photoUrl"]),
                                          radius: 40,
                                          backgroundColor: Colors.grey,
                                        ),
                                        // user stats: posts, followers, following
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  // posts
                                                  buildColumn(
                                                      numPosts, "Posts"),
                                                  // followers
                                                  buildColumn(
                                                     followers,
                                                    "Followers"
                                                  ),
                                                  // following
                                                  buildColumn(
                                                      following,
                                                      "Following",
                                                  ),
                                                ],
                                              ),
                                              // follow button
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 15.0,
                                                    ),
                                                    child:
                                                        Auth().currentUserId == widget.uid
                                                            ? FollowButton(
                                                                backgroundColor: mobileBackground,
                                                                borderColor: Colors.grey,
                                                                text: "Edit Profile",
                                                                textColor: primaryColor,
                                                                function: () {},
                                                              )
                                                            : isFollowed
                                                                ? FollowButton(
                                                                    backgroundColor: primaryColor,
                                                                    borderColor: Colors.grey,
                                                                    text: "Unfollow",
                                                                    textColor: Colors.black,
                                                                    function: () async{
                                                                          await Data().followUser(userData["id"], Auth().currentUserId);
                                                                          setState(() {
                                                                            isFollowed = false;
                                                                            followers--;
                                                                          });
                                                                        },
                                                                  )
                                                                : FollowButton(
                                                                    backgroundColor: Colors.blue,
                                                                    borderColor: Colors.blue,
                                                                    text: "Follow",
                                                                    textColor: primaryColor,
                                                                    function: () async {
                                                                      await Data().followUser(userData["id"], Auth().currentUserId);
                                                                      setState(() {
                                                                        isFollowed = true;
                                                                        followers++;
                                                                      });
                                                                    },
                                                                  ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    Text(
                                      userData["bio"].toString().isEmpty
                                          ? ""
                                          : userData["full name"],
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        top: 1,
                                      ),
                                      child: Text(
                                        userData["bio"],
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    userData["bio"].toString().isEmpty
                                        ? const SizedBox(
                                            height: 0,
                                          )
                                        : const SizedBox(
                                            height: 16,
                                          ),
                                    const Divider(),

                                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                                      future: Data().getUserPost(widget.uid),
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
                                        } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                                          return const Center(
                                            child: Text("No posts"),
                                          );
                                        } else {
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                              ),
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                var posts = snapshot.data!.docs[index].data()["postUrl"];
                                                return posts.toString().isEmpty
                                                    ? const CircularProgressIndicator()
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Image.network(
                                                          posts,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      );
                                              },
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
              );
  }
}

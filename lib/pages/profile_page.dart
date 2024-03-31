import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/add_post_page.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/follow_button.dart';
import '../services/data.dart';
import '../widgets/profile_column.dart';

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
  getData() async {
    var snap = await Data().getUserData(widget.uid);

    // check if the snapshot data is null
    if (snap.exists) {
      // retrieve data only if the snapshot exists
      var data = snap.data();

      // check if data is not null and is of type Map
      if (data != null) {
        numPosts = await Data().getNumberOfPosts(widget.uid);

        // update the state only if the widget is still mounted
        if (mounted) {
          setState(() {
            userData = data;
          });
        }
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userData.isEmpty
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
            body: ListView(
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
                            backgroundImage: NetworkImage(userData["photoUrl"]),
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
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // posts
                                    buildColumn(numPosts, "Posts"),
                                    // followers
                                    buildColumn(userData["followers"].length,
                                        "Followers"),
                                    // following
                                    buildColumn(userData["following"].length,
                                        "Following"),
                                  ],
                                ),
                                // follow button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: FollowButton(
                                        backgroundColor: mobileBackground,
                                        borderColor: Colors.grey,
                                        text: "Edit Profile",
                                        textColor: primaryColor,
                                        function: () {},
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
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

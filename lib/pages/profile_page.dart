import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/add_post_page.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/widgets/follow_button.dart';
import '../widgets/profile_column.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // appBar with user's username as title
        title: const Text(
          "userName",
          style: TextStyle(
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
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1579783483458-83d02161294e?q=80&w=1997&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      ),
                      radius: 40,
                      backgroundColor: Colors.grey,
                    ),
                    // user stats: posts, followers, following
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // posts
                              buildColumn(1, "Posts"),
                              // followers
                              buildColumn(20, "Followers"),
                              // following
                              buildColumn(3, "Following"),
                            ],
                          ),
                          // follow button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: const Text(
                    "username",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 1,
                  ),
                  child: const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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

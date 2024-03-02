import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/utilities/colors.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String userImage;
  final String profImage;
  const PostCard(
      {Key? key,
      required this.username,
      required this.userImage,
      required this.profImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8)
                .copyWith(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        profImage,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(username),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            ),
          ),

          // Image Section
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
            width: double.infinity,
            child: Image.network(userImage),
          ),

          // Like, Comment, Send, & Save Icons  Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.heart_fill,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.comment_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border,
                ),
              ),
            ],
          ),

          //Likes, Description, Number of comments, Date
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // likes
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                  child: Text(
                    "1000 likes",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                // Username & Description
                Container(
                  padding: const EdgeInsets.only(
                    top: 6,
                  ),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: "username",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "  This the description",
                        ),
                      ],
                    ),
                  ),
                ),

                // Number of comments
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: const Text(
                      "View all 500 Comments",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),

                // Date
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: const Text(
                    "3/3/2024",
                    style: TextStyle(
                      fontSize: 10,
                      color: secondaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

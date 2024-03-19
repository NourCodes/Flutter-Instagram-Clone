import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/pages/comments_page.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/utils.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/data.dart';
import 'like_animation.dart';

class PostCard extends StatefulWidget {
  final String postId;
  final String username;
  final String userImage;
  final Timestamp date;
  final String profImage;
  final String description;
  final List likes;
  const PostCard({
    super.key,
    required this.username,
    required this.userImage,
    required this.date,
    required this.profImage,
    required this.likes,
    required this.description,
    required this.postId,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentsLength = 0;
  @override
  void initState() {
    getComments();
    super.initState();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await Data().getComments(widget.postId);
      commentsLength = snap.docs.length;
    } catch (e) {
      showMessage(e.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String currentUserId = Auth().currentUserId;
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
                        widget.profImage,
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(widget.username),
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

          GestureDetector(
            onDoubleTap: () async {
              await Data().likePost(
                widget.postId,
                currentUserId,
                widget.likes,
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: double.infinity,
                  child: Image.network(widget.userImage),
                ),
                AnimatedOpacity(
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Like, Comment, Send, & Save Icons  Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  LikeAnimation(
                    isAnimating: widget.likes.contains(currentUserId),
                    like: true,
                    child: IconButton(
                      onPressed: () async {
                        await Data().likePost(
                          widget.postId,
                          currentUserId,
                          widget.likes,
                        );
                      },
                      icon: widget.likes.contains(currentUserId)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommentsPage(
                          postId: widget.postId,
                        ),
                      ),
                    ),
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
                    "${widget.likes.length} likes",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),

                // Username & Description
                Container(
                  padding: const EdgeInsets.only(
                    top: 6,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: primaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "  ${widget.description}",
                        ),
                      ],
                    ),
                  ),
                ),

                // Number of comments
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommentsPage(
                          postId: widget.postId,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: Text(
                      "View all $commentsLength Comments",
                      style: const TextStyle(
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
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.date.toDate(),
                    ),
                    style: const TextStyle(
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

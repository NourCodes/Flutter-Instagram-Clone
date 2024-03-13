import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                foregroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?q=80&w=1945&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                radius: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'username',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: '  description'),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        '3/13/2024',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

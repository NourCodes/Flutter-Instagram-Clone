import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  const FollowButton({
    super.key,
    this.function,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: const Size(250, 16),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

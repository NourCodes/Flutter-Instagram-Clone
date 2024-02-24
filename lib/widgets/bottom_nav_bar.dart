import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int page;
  final void Function(int)? onTapped;
  const BottomNavBar({Key? key, required this.page, required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      onTap: onTapped,
      backgroundColor: mobileBackground,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: page == 0 ? primaryColor : secondaryColor),
          label: "",
          backgroundColor: primaryColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search,
              color: page == 1 ? primaryColor : secondaryColor),
          label: "",
          backgroundColor: primaryColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle,
              color: page == 2 ? primaryColor : secondaryColor),
          label: "",
          backgroundColor: primaryColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite,
              color: page == 3 ? primaryColor : secondaryColor),
          label: "",
          backgroundColor: primaryColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              color: page == 4 ? primaryColor : secondaryColor),
          label: "",
          backgroundColor: primaryColor,
        ),
      ],
    );
  }
}

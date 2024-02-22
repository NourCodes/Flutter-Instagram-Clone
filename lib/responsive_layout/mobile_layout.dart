import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  // variable to store the user's name
  String name = '';

  @override
  void initState() {
    // call getUsername() method when the screen initializes
    getUsername();
    super.initState();
  }

  // get the current user's ID
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // method to fetch the user's username from Firestore
  void getUsername() async {
    // get the document snapshot of the user with the current UID
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // extract the username from the document snapshot
    String username = (snap.data()! as Map<String, dynamic>)['username'];

    // update the 'name' variable with the fetched username
    setState(() {
      name = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(name),
      ),
    );
  }
}

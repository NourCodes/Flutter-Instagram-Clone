import 'package:flutter/material.dart';
import 'package:instagram_clone/model/userdata_model.dart';
import 'package:instagram_clone/services/data.dart';

//provider class responsible for managing user data
class UserDataProvider extends ChangeNotifier {
  // holds data of the currently logged-in user
  UserDataModel? _userData;
  // instance of data class
  final Data _data = Data();

  // getter method to access the current user data
  UserDataModel get getUserData => _userData!;

  // asynchronous method to fetch the current user's data
  Future<void> getCurrentUserData() async {
    // retrieve user data from Firestore
    UserDataModel data = await _data.getUserDetails();
    // update the current user data
    _userData = data;
    // notify listeners that user data has been updated
    notifyListeners();
  }
}

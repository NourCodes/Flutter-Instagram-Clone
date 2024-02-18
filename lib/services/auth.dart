import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/utilities/utils.dart';
import 'data.dart';

class Auth {
  //create an instance of firebase auth
  final _firebaseAuth = FirebaseAuth.instance;

  //sign up method
  Future<void> signUp(
    String email,
    String password,
    String fullName,
    String userName,
    Uint8List file,
  ) async {
    String message = "";

    try {
      if (email.isEmpty) {
        // display an error message if the email field is empty
        message = 'Please enter your email';
      } else if (password.isEmpty || fullName.isEmpty || userName.isEmpty) {
        // display an error message if any other required fields are empty
        message = 'Please fill in all the required fields';
      } else {
        // proceed with sign-up if all fields are filled
        UserCredential result =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: email.trim(), password: password.trim());
        User? user = result.user;

        // add user details to Firestore
        Data()
            .saveUserData(email, password, fullName, userName, user!.uid, file);
        message = 'Successfully Signed Up';
      }
    } catch (e) {
      // handle other errors
      message = 'An error occurred: ${e.toString()}';
    }

    // display the error message
    showMessage(message);
  }

// log in method
  Future<void> login(String email, String password) async {
    String message = '';
    try {
      if (email.isEmpty) {
        // display an error message if the email field is empty
        message = 'Please enter your email';
      } else if (password.isEmpty) {
        message = 'Please enter your password';
      } else {
        // proceed with login if all fields are filled
        UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim());
        User? user = result.user;
        message = 'Successfully Logged In';
      }
    } catch (e) {
      message = e.toString();
    }

    showMessage(message);
  }
}

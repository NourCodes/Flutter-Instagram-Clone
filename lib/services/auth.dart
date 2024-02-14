import 'package:firebase_auth/firebase_auth.dart';

import 'data.dart';

class Auth {
  //create an instance of firebase auth
  final _firebaseAuth = FirebaseAuth.instance;

  //sign up method
  Future<Object?> signUp(
    String email,
    String password,
    String fullName,
    String userName,
  ) async {
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          fullName.isNotEmpty &&
          userName.isNotEmpty) {
        UserCredential result =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: email.trim(), password: password.trim());
        User? user = result.user;

        // add user details to firestore
        Data().saveUserData(email, password, fullName, userName, user!.uid);

        return user;
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

// log in method
  Future<Object?> login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim());
        User? user = result.user;
        return user!;
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}

import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Storage {
  // create an instance of Firebase Storage
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // create an instance of Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //uploads an image file to Firebase Storage and returns the download URL
  Future<String> uploadImage(
      Uint8List file, bool isPost, String directoryName) async {
    // create a reference to the Firebase Storage location
    Reference ref = _storage
        .ref() //gets the reference to the root of the storage
        .child(directoryName) // create a directory for user images
        .child(_auth.currentUser!
            .uid); // set a unique file name based on the user's UID

    if (isPost) {
      // if it's a post, generate a unique ID for the image
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // upload the image file to Firebase Storage
    await ref.putData(file);

    // get the download URL for the uploaded image
    String picUrl = await ref.getDownloadURL();

    // return the download URL
    return picUrl;
  }
}

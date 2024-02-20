import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';

// this method takes an 'ImageSource' as input and returns a Future Uint8List
uploadImage(ImageSource source) async {
  // create an instance of ImagePicker
  final ImagePicker picker = ImagePicker();

  // pickImage method returns an 'XFile?' which may be null
  XFile? _file = await picker.pickImage(source: source);

  // check if an image was successfully picked
  if (_file != null) {
    // if an image was picked, read the bytes of the file asynchronously and return the file as Uint8List
    return await _file.readAsBytes();
  }
}

showMessage(String msg) {
  showToast(
    msg,
    position: const ToastPosition(align: Alignment.topCenter),
    duration: const Duration(seconds: 5),
  );
}

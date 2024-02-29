import 'dart:typed_data';

import 'package:instagram_clone/model/userdata_model.dart';
import 'package:instagram_clone/provider/userdata_provider.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/services/data.dart';
import 'package:instagram_clone/utilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  Uint8List? _image;
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  Future<void> postImage(
      String id, String username, String profileImage) async {
    setState(() {
      _isLoading = true;
    });
    await Data()
        .uploadPost(id, username, _image!, _controller.text, profileImage);
    setState(() {
      _isLoading = false;
      clearImage();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void clearImage() {
    setState(() {
      _image = null;
    });
  }

  getImage() async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "Create a post",
          ),
          children: [
            SimpleDialogOption(
              child: const Text(
                "Pick a photo",
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List image = await uploadImage(ImageSource.camera);
                setState(() {
                  _image = image;
                });
              },
            ),
            SimpleDialogOption(
              child: const Text(
                "Upload a photo",
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List image = await uploadImage(ImageSource.gallery);
                setState(() {
                  _image = image;
                });
              },
            ),
            SimpleDialogOption(
              child: const Text(
                "Cancel",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserDataModel userData = Provider.of<UserDataProvider>(context).getUserData;

    return (_image == null)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: IconButton(
                  icon: const Icon(Icons.upload),
                  onPressed: getImage,
                ),
              ),
            ],
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackground,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              title: Text(
                'Post to ${userData.userName}',
                style: const TextStyle(color: Colors.white),
              ),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => postImage(
                      userData.id, userData.userName, userData.imageUrl),
                  child: const Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(userData.imageUrl ??
                                'https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Provide a placeholder image
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: "Write a caption",
                                border: InputBorder.none,
                              ),
                              maxLines: 6,
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: AspectRatio(
                              aspectRatio: 480 / 445,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(
                                      _image!,
                                    ),
                                    fit: BoxFit.fill,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      )
              ],
            ),
          );
  }
}

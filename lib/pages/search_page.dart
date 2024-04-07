import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/profile_page.dart';
import 'package:instagram_clone/utilities/colors.dart';
import '../services/data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  bool showPost = true;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    showPost = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextFormField(
          onChanged: (value) {
            setState(() {
              controller.text = value;
              showPost = false;
            });
          },
          onFieldSubmitted: (value) {
            setState(() {
              controller.text = value;
              showPost = false;
            });
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(5),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 70,
                color: Colors.black38,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 70,
                color: Colors.black38,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: primaryColor,
            ),
            hintText: "Search",
          ),
          controller: controller,
        ),
      ),
      body: showPost
          ? FutureBuilder(
              future: Data().posts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Posts Available"),
                  );
                } else {
                  return MasonryGridView.count(
                    itemCount: snapshot.data!.docs.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    itemBuilder: (context, index) {
                      var snaps = snapshot.data!.docs[index];
                      return Image.network(
                        snaps["postUrl"],
                      );
                    },
                  );
                }
              },
            )
          : FutureBuilder(
              future: Data().searchUsers(controller.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // while waiting for data, show a loading indicator
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // if an error occurs, display an error message
                  return Text(
                    'Error: ${snapshot.error}',
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var snaps = snapshot.data.docs[index];
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              uid: snaps["id"],
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            foregroundImage: NetworkImage(
                              snaps["photoUrl"],
                            ),
                          ),
                          title: Text(
                            snaps["username"],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}

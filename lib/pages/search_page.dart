import 'package:flutter/material.dart';
import '../services/data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          onChanged: (value) {
            setState(() {
              controller.text = value;
            });
          },
          onFieldSubmitted: (value) {
            setState(() {
              controller.text = value;
            });
          },
          decoration: const InputDecoration(hintText: "Search for users"),
          controller: controller,
        ),
      ),
      body: FutureBuilder(
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
                return ListTile(
                  leading: CircleAvatar(
                    foregroundImage: NetworkImage(snaps["photoUrl"]),
                  ),
                  title: Text(snaps["username"]),
                );
              },
            );
          }
        },
      ),
    );
  }
}

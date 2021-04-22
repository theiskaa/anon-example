import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/core/utils/fire.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePost extends AnonStatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends AnonState<CreatePost> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                maxLines: 30,
                controller: contentController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                var post = PostModel(
                  userID: fireauthInstance.currentUser.uid ?? "Anon",
                  content: contentController.text,
                  title: titleController.text,
                );

                BlocProvider.of<UserserviceBloc>(context).add(
                  UserServiceEvent.createPostStart(post),
                );
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}

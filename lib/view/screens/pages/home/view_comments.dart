import 'package:anon/core/model/post.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewComments extends AnonStatelessWidget {
  final PostModel post;

  ViewComments({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        centerWidget: Text(
          "Comments of - ${post.title}",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: post.comments.length > 0 ? buildBody() : emptyList(),
    );
  }

  Widget emptyList() => Center(
        child: Text("This post hasn't any comment, let's add first!"),
      );

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: post.comments.map((comment) => commentCard(comment)).toList(),
      ),
    );
  }

  ListTile commentCard(comment) {
    return ListTile(
      title: Text(comment['title']),
      leading: Icon(
        CupertinoIcons.arrowshape_turn_up_right_fill,
        color: Colors.blueGrey,
      ),
    );
  }
}

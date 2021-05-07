import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/comment_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewComments extends AnonStatefulWidget {
  final PostModel post;
  ViewComments({@required this.post});

  @override
  _ViewCommentsState createState() => _ViewCommentsState();
}

class _ViewCommentsState extends AnonState<ViewComments> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        centerWidget: Text(
          "Comments of - ${widget.post.title}",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: widget.post.comments.length > 0 ? buildBody() : emptyList(),
      bottomNavigationBar: CommentField(
        controller: _controller,
        onSend: onPutComment,
      ),
    );
  }

  void onPutComment() async {
    var comment = CommentModel(title: _controller.text);
    BlocProvider.of<UserserviceBloc>(context).add(
      UserServiceEvent.putCommentStart(widget.post, comment),
    );
    await Future.delayed(Duration(seconds: 2));
    setState(() => _controller.text = "");
  }

  Widget emptyList() => Center(
        child: Text("This post hasn't any comment yet"),
      );

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: widget.post.comments
            .map((comment) => commentCard(comment))
            .toList(),
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

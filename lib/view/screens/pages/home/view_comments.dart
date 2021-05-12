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
  final bool postIsSaved;
  final PostModel post;
  ViewComments({@required this.post, this.postIsSaved = false});

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
      body: bodyWithListener(),
      bottomNavigationBar: widget.postIsSaved
          ? SizedBox.shrink()
          : CommentField(
              controller: _controller,
              onSend: onPutComment,
            ),
    );
  }

  BlocListener<UserserviceBloc, UserServiceState> bodyWithListener() {
    return BlocListener<UserserviceBloc, UserServiceState>(
      listener: (context, state) {
        if (state.event == UserServiceEvents.putCommentError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red[800],
            content: Text(
              "Something went wrong when you trying posting comment, please try again later..",
            ),
          ));
        }
      },
      child:
          widget.post.comments.length > 0 ? buildCommentsBody() : emptyList(),
    );
  }

  void onPutComment() async {
    if (_controller.text.length > 3) {
      var comment = CommentModel(title: _controller.text);
      BlocProvider.of<UserserviceBloc>(context).add(
        UserServiceEvent.putCommentStart(widget.post, comment),
      );
      await Future.delayed(Duration(milliseconds: 500));
      setState(() => _controller.text = "");
    }
  }

  Widget emptyList() => Center(
        child: Text("This post hasn't any comment"),
      );

  SingleChildScrollView buildCommentsBody() {
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

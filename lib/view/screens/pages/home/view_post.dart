import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/bottombars.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/utils/snack_messages.dart';
import 'package:anon/view/widgets/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import 'view_comments.dart';

class ViewPost extends AnonStatefulWidget {
  final bool postIsSaved;
  final PostModel postModel;
  ViewPost({@required this.postModel, this.postIsSaved = false});
  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends AnonState<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserserviceBloc, UserServiceState>(
      listener: (context, state) {
        if (state.event == UserServiceEvents.savePostSuccess)
          showSnack(context, 'Added to favorite posts list');
      },
      child: Scaffold(
        appBar: buildAppBar(),
        body: buildBody(),
        bottomNavigationBar: viewCommentsBar(context),
      ),
    );
  }

  DefaultAppBar buildAppBar() {
    return DefaultAppBar(
      actions: widget.postIsSaved
          ? null
          : [
              OpacityButton(
                child: Icon(Icons.favorite_rounded, color: Colors.black),
                onTap: () {
                  BlocProvider.of<UserserviceBloc>(context).add(
                    UserServiceEvent.savePostStart(widget.postModel),
                  );
                },
              ),
              SizedBox(width: 15),
            ],
    );
  }

  ViewCommentsBar viewCommentsBar(BuildContext context) {
    return ViewCommentsBar(
      commentsLength: widget.postModel.comments.length,
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ViewComments(post: widget.postModel),
        ),
      ),
    );
  }

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          titleWidget(),
          SizedBox(height: 20),
          divider,
          SizedBox(height: 20),
          contentBodyAsMarkdown(),
        ],
      ),
    );
  }

  Container contentBodyAsMarkdown() {
    return Container(
      alignment: Alignment.topLeft,
      child: MarkdownBody(
        data: widget.postModel.content,
        selectable: true,
        onTapLink: (text, href, title) => launch(href),
      ),
    );
  }

  titleWidget() => Text(
        widget.postModel.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w900,
        ),
      );
}

import 'package:anon/core/model/post.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/bottombars.dart';
import 'package:anon/view/widgets/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewPost extends AnonStatefulWidget {
  final PostModel postModel;
  ViewPost({@required this.postModel});
  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends AnonState<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      body: buildBody(),
      bottomNavigationBar: widget.postModel.comments.length > 0
          ? ViewCommentsBar(
              commentsLength: widget.postModel.comments.length,
              onTap: () {},
            )
          : SizedBox.shrink(),
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

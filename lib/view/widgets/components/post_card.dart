import 'dart:ui';

import 'package:anon/core/model/post.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anon/view/widgets/utils/ext.dart' as ext;

import '../anon_widgets.dart';

class PostCardWidget extends AnonStatelessWidget {
  final PostModel postModel;
  final Function onTap;
  final Function onViewCommentsTap;

  PostCardWidget({
    Key key,
    @required this.postModel,
    @required this.onTap,
    @required this.onViewCommentsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpacityButton(
      key: Key('card.button'),
      onTap: onTap,
      onLongPress: onViewCommentsTap,
      opacityValue: .5,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: postModel.color.toColor(),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [buildTitleWidget(), SizedBox(height: 10), buildComments()],
        ),
      ),
    );
  }

  Container buildComments() {
    return Container(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(CupertinoIcons.bubble_left_bubble_right_fill),
          SizedBox(width: 5),
          Text(
            postModel.comments.length > 0
                ? "${postModel.comments.length}"
                : "N",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }

  Container buildTitleWidget() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        postModel.title ?? "",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

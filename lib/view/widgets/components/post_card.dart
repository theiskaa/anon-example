import 'dart:ui';

import 'package:anon/core/model/post.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';

import '../anon_widgets.dart';

class PostCardWidget extends AnonStatelessWidget {
  final PostModel postModel;
  final Function onTap;
  final Function onViewCommentsTap;

  PostCardWidget({
    Key key,
    @required this.postModel,
    @required this.onTap,
    this.onViewCommentsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpacityButton(
      key: Key('card.button'),
      onTap: onTap,
      opacityValue: .7,
      child: Stack(
        children: [
          buildButtonBody(context),
          likeCounterCircle(),
        ],
      ),
    );
  }

  Container likeCounterCircle() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blueGrey,
        ),
      ),
      child: Center(
        child: Text(
          "N",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Container buildButtonBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width - 50,
      decoration: buildCardDecoration(),
      child: Column(
        children: [
          buildTitleWidget(),
          SizedBox(height: 30),
          buildDownActs(),
        ],
      ),
    );
  }

  Padding buildDownActs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTaptoViewMoreHolder(),
          buildViewCommentsButton(),
        ],
      ),
    );
  }

  Widget buildTaptoViewMoreHolder() {
    if (postModel.content.length > 10) {
      return Text(
        'Tap to view more',
        style: TextStyle(
          color: Colors.black.withOpacity(.5),
        ),
      );
    } else {
      return SizedBox.shrink(key: Key("SizedBox.shrink"));
    }
  }

  OpacityButton buildViewCommentsButton() {
    return OpacityButton(
      key: Key('view.comments.button'),
      onTap: onViewCommentsTap,
      child: Text(
        'View comments',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Container buildTitleWidget() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 10),
      child: Text(
        postModel.title ?? "",
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  BoxDecoration buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.blueGrey[700], width: 2),
      borderRadius: BorderRadius.circular(20),
    );
  }
}

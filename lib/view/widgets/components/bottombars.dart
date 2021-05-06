import 'package:flutter/material.dart';

import 'opacity_button.dart';

class ViewCommentsBar extends StatelessWidget {
  final int commentsLength;
  final Function onTap;

  const ViewCommentsBar({
    Key key,
    @required this.commentsLength,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpacityButton(
      key: Key("view.comments.bar"),
      opacityValue: .9,
      onTap: onTap,
      child: Container(
        height: 50,
        color: Colors.black,
        child: Center(
          child: buildTitle(),
        ),
      ),
    );
  }

  Text buildTitle() => Text(
        commentsLength > 0 ? "View comments ($commentsLength)" : "Add comment",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
}

import 'package:flutter/material.dart';

import 'opacity_button.dart';

class ViewCommentsBar extends StatelessWidget {
  final int commentsLength;
  final Function onTap;
  final Color? color;

  const ViewCommentsBar(
      {Key? key, required this.commentsLength, required this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpacityButton(
      key: Key("view.comments.bar"),
      opacityValue: .9,
      onTap: onTap as void Function()?,
      child: Container(
        height: 50,
        color: color ?? Colors.black,
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

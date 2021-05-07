import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../anon_widgets.dart';
import 'animated_add_button.dart';

class CommentField extends AnonStatelessWidget {
  final TextEditingController controller;
  final Function onSend;

  CommentField({
    Key key,
    @required this.controller,
    @required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: body(),
    );
  }

  Container body() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 15, right: 20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey.withOpacity(.3)),
        color: Colors.blueGrey[900].withOpacity(.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            field(),
            AnimatedAddButton(
              key: Key("send.button"),
              onTap: onSend,
            )
          ],
        ),
      ),
    );
  }

  Widget field() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: CupertinoTextField(
          key: Key('comment.field'),
          placeholder: 'Type..',
          controller: controller,
        ),
      ),
    );
  }
}

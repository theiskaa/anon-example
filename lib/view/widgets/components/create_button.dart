import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';

class CreateButton extends AnonStatelessWidget {
  final Function onTap;
  final Color backgroundColor;
  final String title;
  final Color titleColor;

  CreateButton({
    Key? key,
    required this.onTap,
    this.backgroundColor = Colors.black,
    this.title = "Create",
    this.titleColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpacityButton(
      onTap: onTap as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        height: 15,
        width: 60,
        decoration: buildButtonDecoration(),
        child: buildTitle(),
      ),
    );
  }

  buildButtonDecoration() => BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      );

  buildTitle() => Center(
        child: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
      );
}

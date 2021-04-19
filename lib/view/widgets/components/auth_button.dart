import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';

class AuthButton extends AnonStatelessWidget {
  final String title;
  final Function onTap;
  final double height;
  final Color backgroundColor;
  final Color titleColor;
  final FontWeight titleWeight;

  AuthButton({
    Key key,
    @required this.title,
    @required this.onTap,
    this.height = 120,
    this.backgroundColor = Colors.black,
    this.titleColor = Colors.white,
    this.titleWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpacityButton(
      opacityValue: .8,
      onTap: onTap,
      child: buttonBody(),
    );
  }

  Container buttonBody() {
    return Container(
      height: height,
      color: backgroundColor,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: titleColor,
            fontWeight: titleWeight,
          ),
        ),
      ),
    );
  }
}

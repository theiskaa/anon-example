import 'package:flutter/material.dart';

void showSnack(
  BuildContext context,
  String title, {
  Color backgroundColor = Colors.black,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      margin: EdgeInsets.all(10),
      content: Text(title, style: TextStyle(color: Colors.white)),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom divider.
Widget get divider {
  return Divider(
    height: 5,
    thickness: 1,
    indent: 50,
    endIndent: 50,
  );
}

Center get loadingIndicator {
  return Center(child: CupertinoActivityIndicator(radius: 20));
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom divider.
Widget get divider {
  return const Divider(
    height: 5,
    thickness: 1,
    indent: 50,
    endIndent: 50,
  );
}

Center get loadingIndicator {
  return const Center(child: const CupertinoActivityIndicator(radius: 20));
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'anon_widgets.dart';

class Loading extends AnonStatelessWidget {
  Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(radius: 25),
    );
  }
}

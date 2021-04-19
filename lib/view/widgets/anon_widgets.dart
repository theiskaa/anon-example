import 'package:anon/core/system/anon.dart';
import 'package:flutter/widgets.dart';

/// Custom [StatelessWidget] implemented [Anon] singleton
abstract class AnonStatelessWidget extends StatelessWidget {
  AnonStatelessWidget({Key key}) : super(key: key);
  final Anon anon = Anon();
}

/// Custom [StatefulWidget] implemented [Anon] singleton
abstract class AnonStatefulWidget extends StatefulWidget {
  AnonStatefulWidget({Key key}) : super(key: key);
  final Anon anon = Anon();
}

/// Custom [State] implemented [Anon] singleton for [AnonStatefulWidget]
abstract class AnonState<B extends AnonStatefulWidget> extends State<B> {
  final Anon anon = Anon();
}

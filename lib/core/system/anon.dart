import 'logger.dart';

/// The main singleton of the project.
/// It able to use just by using [AnonStatelessWidget] or [AnonStatefulWidget].
class Anon {
  static final Anon _singleton = Anon._internal();

  final Map<String, dynamic> instances = {};

  factory Anon() {
    return _singleton;
  }

  Anon._internal() {
    Log.v("${this.runtimeType.toString()} instance created");
  }
}

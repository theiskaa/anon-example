import 'package:anon/core/system/logger.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class AnonBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    Log.d("[ onEvent $event ]");
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    Log.d("Prev State Event: ${transition.currentState.event}\r\n" +
        "Next State Event: ${transition.nextState.event}");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    Log.e(bloc, error, stacktrace);
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/blocs/bloc_observer.dart';
import 'core/system/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // System configurations.
  Log.level = 'verbose';
  Bloc.observer = AnonBlocObserver();

  runApp(App());
}

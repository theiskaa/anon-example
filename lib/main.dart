import 'package:flutter/material.dart';

import 'app.dart';
import 'core/system/logger.dart';

void main() {
  // Configure
  Log.level = 'verbose';

  runApp(App());
}

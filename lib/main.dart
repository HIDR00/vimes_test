import 'dart:async';
import 'package:base/app/my_app/my_app.dart';
import 'package:base/firebase_options.dart';
import 'package:base/shared/src/utils/log_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/di/di.dart' as di;
import 'shared/shared.dart';

void main() => runZonedGuarded(_runApp, _onError);

void _runApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvConstants.init();
  di.configureInjection();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

void _onError(Object error, StackTrace stackTrace) {
  Log.e(error.toString(), stackTrace: stackTrace, name: 'Uncaught exception');
}

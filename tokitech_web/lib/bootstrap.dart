import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'firebase_options.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runZonedGuarded(
    () => runApp(const ProviderScope(child: TokiTechApp())),
    (error, stackTrace) => debugPrint('Unhandled error: $error\n$stackTrace'),
  );
}

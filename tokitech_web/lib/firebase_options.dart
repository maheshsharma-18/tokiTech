import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Placeholder Firebase configuration.
/// Replace the values below by running `flutterfire configure` once
/// the actual Firebase project is ready.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: 'TODO_WEB_API_KEY',
        appId: 'TODO_WEB_APP_ID',
        messagingSenderId: 'TODO_SENDER_ID',
        projectId: 'TODO_PROJECT_ID',
        authDomain: 'TODO_AUTH_DOMAIN',
        storageBucket: 'TODO_STORAGE_BUCKET',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: 'TODO_ANDROID_API_KEY',
          appId: 'TODO_ANDROID_APP_ID',
          messagingSenderId: 'TODO_SENDER_ID',
          projectId: 'TODO_PROJECT_ID',
          storageBucket: 'TODO_STORAGE_BUCKET',
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const FirebaseOptions(
          apiKey: 'TODO_IOS_API_KEY',
          appId: 'TODO_IOS_APP_ID',
          messagingSenderId: 'TODO_SENDER_ID',
          projectId: 'TODO_PROJECT_ID',
          storageBucket: 'TODO_STORAGE_BUCKET',
          iosClientId: 'TODO_IOS_CLIENT_ID',
          iosBundleId: 'TODO_IOS_BUNDLE_ID',
        );
      case TargetPlatform.windows:
        return const FirebaseOptions(
          apiKey: 'TODO_WINDOWS_API_KEY',
          appId: 'TODO_WINDOWS_APP_ID',
          messagingSenderId: 'TODO_SENDER_ID',
          projectId: 'TODO_PROJECT_ID',
          storageBucket: 'TODO_STORAGE_BUCKET',
        );
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
        return const FirebaseOptions(
          apiKey: 'TODO_DESKTOP_API_KEY',
          appId: 'TODO_DESKTOP_APP_ID',
          messagingSenderId: 'TODO_SENDER_ID',
          projectId: 'TODO_PROJECT_ID',
          storageBucket: 'TODO_STORAGE_BUCKET',
        );
    }
  }
}

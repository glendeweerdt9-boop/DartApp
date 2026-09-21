import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: String.fromEnvironment('FIREBASE_WEB_API_KEY'),
        appId: String.fromEnvironment('FIREBASE_WEB_APP_ID'),
        messagingSenderId: String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
        authDomain: String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
        storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
        measurementId: String.fromEnvironment('FIREBASE_MEASUREMENT_ID'),
      );
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: String.fromEnvironment('FIREBASE_ANDROID_API_KEY'),
        appId: String.fromEnvironment('FIREBASE_ANDROID_APP_ID'),
        messagingSenderId: String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
        storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
      );
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const FirebaseOptions(
        apiKey: String.fromEnvironment('FIREBASE_IOS_API_KEY'),
        appId: String.fromEnvironment('FIREBASE_IOS_APP_ID'),
        messagingSenderId: String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'),
        projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
        storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
        iosBundleId: String.fromEnvironment(
          'FIREBASE_IOS_BUNDLE_ID',
          defaultValue: 'com.glendeweerdt.dart_app',
        ),
      );
    }
    throw UnsupportedError('Firebase is not configured for this platform.');
  }
}

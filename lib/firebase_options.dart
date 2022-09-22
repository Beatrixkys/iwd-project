// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvH-PGFYcsTgY_hcHth95cLnOfK-zNUGE',
    appId: '1:504172434544:web:5e413b0db57a21f5fad0b5',
    messagingSenderId: '504172434544',
    projectId: 'iwd-project-3aad9',
    authDomain: 'iwd-project-3aad9.firebaseapp.com',
    storageBucket: 'iwd-project-3aad9.appspot.com',
    measurementId: 'G-8QVN5C5QZT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANaCKFwNySgPH6lBbhRHvpSQvS4hJPO9Q',
    appId: '1:504172434544:android:36407d7f014f4d8afad0b5',
    messagingSenderId: '504172434544',
    projectId: 'iwd-project-3aad9',
    storageBucket: 'iwd-project-3aad9.appspot.com',
  );
}

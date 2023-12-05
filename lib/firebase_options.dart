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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyCzZIt07XrRXfbXeny54q_OCDdBXISAHMI',
    appId: '1:757712297169:web:eccf19277906b9d132b9f0',
    messagingSenderId: '757712297169',
    projectId: 'smartnote-c660a',
    authDomain: 'smartnote-c660a.firebaseapp.com',
    storageBucket: 'smartnote-c660a.appspot.com',
    measurementId: 'G-S58KHX8MYD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCi0XYEoxly5G1IQhc7zebuSySIhJjsR8w',
    appId: '1:757712297169:android:dd6fabc148dd45bc32b9f0',
    messagingSenderId: '757712297169',
    projectId: 'smartnote-c660a',
    storageBucket: 'smartnote-c660a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwgsWviu_IHZr8qtha8hceBTW8Pw3Y2hs',
    appId: '1:757712297169:ios:3053bfdc136a0a0b32b9f0',
    messagingSenderId: '757712297169',
    projectId: 'smartnote-c660a',
    storageBucket: 'smartnote-c660a.appspot.com',
    iosBundleId: 'com.example.smartnote',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwgsWviu_IHZr8qtha8hceBTW8Pw3Y2hs',
    appId: '1:757712297169:ios:0bb8d01a5d84721f32b9f0',
    messagingSenderId: '757712297169',
    projectId: 'smartnote-c660a',
    storageBucket: 'smartnote-c660a.appspot.com',
    iosBundleId: 'com.example.smartnote.RunnerTests',
  );
}

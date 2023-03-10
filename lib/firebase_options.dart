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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2a15S6SSFIkaTDzhRJdlsqwyyLYycgMs',
    appId: '1:1044312033911:android:a9d9c87180f368f19f1472',
    messagingSenderId: '1044312033911',
    projectId: 'nutrial-f7956',
    databaseURL: 'https://nutrial-f7956-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'nutrial-f7956.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLHfi_YV8AmctAwiesM2r9LIlNgpuFih0',
    appId: '1:1044312033911:ios:9f953e9a7471d7b29f1472',
    messagingSenderId: '1044312033911',
    projectId: 'nutrial-f7956',
    databaseURL: 'https://nutrial-f7956-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'nutrial-f7956.appspot.com',
    iosClientId: '1044312033911-v5u10dj1gebbl7cjksg819kvc5glkc3p.apps.googleusercontent.com',
    iosBundleId: 'com.example.nutrial',
  );
}

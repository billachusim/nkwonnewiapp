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
        return windows;
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
    apiKey: 'AIzaSyBVekh-geE4VGmlePYkaX0klAWZL2TiGHY',
    appId: '1:179851089730:web:fa3001b417bf17d4351adb',
    messagingSenderId: '179851089730',
    projectId: 'nkwo-nnewi-app',
    authDomain: 'nkwo-nnewi-app.firebaseapp.com',
    storageBucket: 'nkwo-nnewi-app.appspot.com',
    measurementId: 'G-FYLXZF09BM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5FM3CsOYVrVsad1_5iJ1m1fYEniSp0Yw',
    appId: '1:179851089730:android:a28881091e27f6ff351adb',
    messagingSenderId: '179851089730',
    projectId: 'nkwo-nnewi-app',
    storageBucket: 'nkwo-nnewi-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6PMg3BifsnWALrnF5JabvNvUhtP_C6ZQ',
    appId: '1:179851089730:ios:3b69972f509d11e0351adb',
    messagingSenderId: '179851089730',
    projectId: 'nkwo-nnewi-app',
    storageBucket: 'nkwo-nnewi-app.appspot.com',
    iosBundleId: 'com.techfaculty.nkwonnewiapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6PMg3BifsnWALrnF5JabvNvUhtP_C6ZQ',
    appId: '1:179851089730:ios:3b69972f509d11e0351adb',
    messagingSenderId: '179851089730',
    projectId: 'nkwo-nnewi-app',
    storageBucket: 'nkwo-nnewi-app.appspot.com',
    iosBundleId: 'com.techfaculty.nkwonnewiapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBVekh-geE4VGmlePYkaX0klAWZL2TiGHY',
    appId: '1:179851089730:web:97a1a05649e6eae2351adb',
    messagingSenderId: '179851089730',
    projectId: 'nkwo-nnewi-app',
    authDomain: 'nkwo-nnewi-app.firebaseapp.com',
    storageBucket: 'nkwo-nnewi-app.appspot.com',
    measurementId: 'G-93QPJPMDP9',
  );

}
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
    apiKey: 'AIzaSyCOfR70DJi3lF1u7WuKTwrJ8Kir0jp2ago',
    appId: '1:275697889881:web:184bc4a4f3fb81a2d5f748',
    messagingSenderId: '275697889881',
    projectId: 'gpsd-project',
    authDomain: 'gpsd-project.firebaseapp.com',
    storageBucket: 'gpsd-project.appspot.com',
    measurementId: 'G-JPJZDCRTCN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHyJw8vvHJCpgaob3fknFe5Af3BKwK3C4',
    appId: '1:275697889881:android:b0d6d8a6fce58ccad5f748',
    messagingSenderId: '275697889881',
    projectId: 'gpsd-project',
    storageBucket: 'gpsd-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBujK2DGAe-7l6Sdc5buEE1c_oEpSYwuP0',
    appId: '1:275697889881:ios:1ba1cdd2995d8d06d5f748',
    messagingSenderId: '275697889881',
    projectId: 'gpsd-project',
    storageBucket: 'gpsd-project.appspot.com',
    iosClientId:
        '275697889881-h8oo5o6k5n1r21oopv08v1vn09ed5omv.apps.googleusercontent.com',
    iosBundleId: 'com.example.gpsdProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBujK2DGAe-7l6Sdc5buEE1c_oEpSYwuP0',
    appId: '1:275697889881:ios:1ba1cdd2995d8d06d5f748',
    messagingSenderId: '275697889881',
    projectId: 'gpsd-project',
    storageBucket: 'gpsd-project.appspot.com',
    iosClientId:
        '275697889881-h8oo5o6k5n1r21oopv08v1vn09ed5omv.apps.googleusercontent.com',
    iosBundleId: 'com.example.gpsdProject',
  );
}

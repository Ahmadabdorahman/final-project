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
    apiKey: 'AIzaSyCib6EEaWJqaFMA12Sz1sJxM5leDOitDYU',
    appId: '1:634188239698:web:5e475aa0eed2e2ecf5608b',
    messagingSenderId: '634188239698',
    projectId: 'e-commerce-65bf7',
    authDomain: 'e-commerce-65bf7.firebaseapp.com',
    storageBucket: 'e-commerce-65bf7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOrUqW5Wxuew7lDyNd4kXEo1CZnSLHcgs',
    appId: '1:634188239698:android:c7f8afb6e3014957f5608b',
    messagingSenderId: '634188239698',
    projectId: 'e-commerce-65bf7',
    storageBucket: 'e-commerce-65bf7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2L9uF-yz-ZuCzMnnAf_dxmMGHj_-bi7k',
    appId: '1:634188239698:ios:e67ce3633a074be5f5608b',
    messagingSenderId: '634188239698',
    projectId: 'e-commerce-65bf7',
    storageBucket: 'e-commerce-65bf7.appspot.com',
    iosBundleId: 'com.example.flowerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2L9uF-yz-ZuCzMnnAf_dxmMGHj_-bi7k',
    appId: '1:634188239698:ios:e67ce3633a074be5f5608b',
    messagingSenderId: '634188239698',
    projectId: 'e-commerce-65bf7',
    storageBucket: 'e-commerce-65bf7.appspot.com',
    iosBundleId: 'com.example.flowerApp',
  );
}

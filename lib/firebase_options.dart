// File generated by FlutLab.
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
          'DefaultFirebaseOptions have not been configured for iOS - '
          'try to add using FlutLab Firebase Configuration',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'it not supported by FlutLab yet, but you can add it manually',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'it not supported by FlutLab yet, but you can add it manually',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'it not supported by FlutLab yet, but you can add it manually',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAT5c1jWi701Iydm1Nx-CaCCRdGDlyi4tw',
    authDomain: 'xang-75cbe.firebaseapp.com',
    projectId: 'xang-75cbe',
    storageBucket: 'xang-75cbe.appspot.com',
    messagingSenderId: '847434827090',
    appId: '1:847434827090:web:6e0bc793e8a1d740ba268b',
    measurementId: 'G-G48X5DB6HE'
  );

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyD3rYwZa56aypBQV4s4hKLduOrNrlOsbdE',
      appId: '1:847434827090:android:85f0ccd612168963ba268b',
      messagingSenderId: '847434827090',
      projectId: 'xang-75cbe',
      storageBucket: 'xang-75cbe.appspot.com');
}

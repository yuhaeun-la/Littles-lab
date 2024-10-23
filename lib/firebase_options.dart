// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyDMejpxmjCE2QyIORyPqx5ue-nUa6B4g_o',
    appId: '1:112187387260:android:df0ec0b0c8f0394de288f9',
    messagingSenderId: '112187387260',
    projectId: 'use-firebase-584a7',
    databaseURL: 'https://use-firebase-584a7-default-rtdb.firebaseio.com',
    storageBucket: 'use-firebase-584a7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxrgQY_mmnkK0sW44-jNXUi0pL7mKYhE0',
    appId: '1:112187387260:ios:fc7d5ad4e7d4dd3ae288f9',
    messagingSenderId: '112187387260',
    projectId: 'use-firebase-584a7',
    databaseURL: 'https://use-firebase-584a7-default-rtdb.firebaseio.com',
    storageBucket: 'use-firebase-584a7.appspot.com',
    iosClientId: '112187387260-75bbob02blk8j73v3kaqr1v9902vve74.apps.googleusercontent.com',
    iosBundleId: 'com.yuhaeun.carelink',
  );

}
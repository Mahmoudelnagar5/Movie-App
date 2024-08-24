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
    apiKey: 'AIzaSyCKBaVXa-5CJBTMMTZyVCNx64ux_7bl2vs',
    appId: '1:712243751217:web:6cf521e2e16cf8c715a810',
    messagingSenderId: '712243751217',
    projectId: 'movie-app-9a8bf',
    authDomain: 'movie-app-9a8bf.firebaseapp.com',
    storageBucket: 'movie-app-9a8bf.appspot.com',
    measurementId: 'G-6XQLEJEX1J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBMN5VHugnR82o3_uH2_gwg8YQX82T1F4',
    appId: '1:712243751217:android:3fd7bb3be443fe5215a810',
    messagingSenderId: '712243751217',
    projectId: 'movie-app-9a8bf',
    storageBucket: 'movie-app-9a8bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-uZ367GLtMBd5OTDBEQ7jvi79E1qH6rQ',
    appId: '1:712243751217:ios:7daaa52734729cc615a810',
    messagingSenderId: '712243751217',
    projectId: 'movie-app-9a8bf',
    storageBucket: 'movie-app-9a8bf.appspot.com',
    iosBundleId: 'com.example.movieApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-uZ367GLtMBd5OTDBEQ7jvi79E1qH6rQ',
    appId: '1:712243751217:ios:7daaa52734729cc615a810',
    messagingSenderId: '712243751217',
    projectId: 'movie-app-9a8bf',
    storageBucket: 'movie-app-9a8bf.appspot.com',
    iosBundleId: 'com.example.movieApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKBaVXa-5CJBTMMTZyVCNx64ux_7bl2vs',
    appId: '1:712243751217:web:f484bc3a2fb8a45515a810',
    messagingSenderId: '712243751217',
    projectId: 'movie-app-9a8bf',
    authDomain: 'movie-app-9a8bf.firebaseapp.com',
    storageBucket: 'movie-app-9a8bf.appspot.com',
    measurementId: 'G-GDS3P92ZDD',
  );
}

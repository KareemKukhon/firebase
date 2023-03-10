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
    apiKey: 'AIzaSyCEiaq8Sly01J4fG3A8DGM7T2KD6v_v2Q0',
    appId: '1:476183327594:web:d0b410753113d83df32b13',
    messagingSenderId: '476183327594',
    projectId: 'ecommerce-app-55953',
    authDomain: 'ecommerce-app-55953.firebaseapp.com',
    storageBucket: 'ecommerce-app-55953.appspot.com',
    measurementId: 'G-H93H18PZY9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDU_raaLO-pJpS_W3vfkqW6XkNEjUzIjDc',
    appId: '1:476183327594:android:8346169e8a590009f32b13',
    messagingSenderId: '476183327594',
    projectId: 'ecommerce-app-55953',
    storageBucket: 'ecommerce-app-55953.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqqV9UBCN1oFCHlPHaZHpRCk7Bzp_Awfk',
    appId: '1:476183327594:ios:66b72dec5e3ca901f32b13',
    messagingSenderId: '476183327594',
    projectId: 'ecommerce-app-55953',
    storageBucket: 'ecommerce-app-55953.appspot.com',
    iosClientId: '476183327594-55q3d22gij13k5kk2jtce5351er7nidv.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication18Firebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqqV9UBCN1oFCHlPHaZHpRCk7Bzp_Awfk',
    appId: '1:476183327594:ios:66b72dec5e3ca901f32b13',
    messagingSenderId: '476183327594',
    projectId: 'ecommerce-app-55953',
    storageBucket: 'ecommerce-app-55953.appspot.com',
    iosClientId: '476183327594-55q3d22gij13k5kk2jtce5351er7nidv.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication18Firebase',
  );
}

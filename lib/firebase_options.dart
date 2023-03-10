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
    apiKey: 'AIzaSyCzONDjSZJDM8VfBajuxMtdvDkPqhH4xLo',
    appId: '1:254394680180:web:001d40d28f71d2d5a6a221',
    messagingSenderId: '254394680180',
    projectId: 'caparrots-ed3ff',
    authDomain: 'caparrots-ed3ff.firebaseapp.com',
    databaseURL: 'https://caparrots-ed3ff-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'caparrots-ed3ff.appspot.com',
    measurementId: 'G-82XLGM8V9R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGcozPwdsmJN-uQJZnLYXjIoH65nJvAIY',
    appId: '1:254394680180:android:00d2ec52cf34a6c0a6a221',
    messagingSenderId: '254394680180',
    projectId: 'caparrots-ed3ff',
    databaseURL: 'https://caparrots-ed3ff-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'caparrots-ed3ff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUy5N-hUDbtixerFZLByYy7CUKzgLOK5A',
    appId: '1:254394680180:ios:7102034e59409481a6a221',
    messagingSenderId: '254394680180',
    projectId: 'caparrots-ed3ff',
    databaseURL: 'https://caparrots-ed3ff-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'caparrots-ed3ff.appspot.com',
    androidClientId: '254394680180-i78a6e5ekagtgqdofrhhtsq7lv3hbems.apps.googleusercontent.com',
    iosClientId: '254394680180-hnvnoorhsbtfi2918phf6kks27gq358f.apps.googleusercontent.com',
    iosBundleId: 'Francisco.caparrotsGoFinal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUy5N-hUDbtixerFZLByYy7CUKzgLOK5A',
    appId: '1:254394680180:ios:7102034e59409481a6a221',
    messagingSenderId: '254394680180',
    projectId: 'caparrots-ed3ff',
    databaseURL: 'https://caparrots-ed3ff-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'caparrots-ed3ff.appspot.com',
    androidClientId: '254394680180-i78a6e5ekagtgqdofrhhtsq7lv3hbems.apps.googleusercontent.com',
    iosClientId: '254394680180-hnvnoorhsbtfi2918phf6kks27gq358f.apps.googleusercontent.com',
    iosBundleId: 'Francisco.caparrotsGoFinal',
  );
}

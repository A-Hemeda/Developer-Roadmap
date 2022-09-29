import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDO09X_GzuDot6CNeeB8q28WODVYfh8laI',
    appId: '1:964560860962:web:eabb84b146949b379fd77b',
    messagingSenderId: '964560860962',
    projectId: 'bookingapp-df000',
    authDomain: 'bookingapp-df000.firebaseapp.com',
    storageBucket: 'bookingapp-df000.appspot.com',
    measurementId: 'G-E509J30KV8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0WF9TE5EcUXO8VRi2c5GpYtUniV_uzu0',
    appId: '1:964560860962:android:ec9ce7c772e7a9a49fd77b',
    messagingSenderId: '964560860962',
    projectId: 'bookingapp-df000',
    storageBucket: 'bookingapp-df000.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA07WjQ0FfJbkH83lOH98RyjJuua0PxPKQ',
    appId: '1:964560860962:ios:bd04b58a133a5b269fd77b',
    messagingSenderId: '964560860962',
    projectId: 'bookingapp-df000',
    storageBucket: 'bookingapp-df000.appspot.com',
    iosClientId:
        '964560860962-nhas319gv9o7pju2shlhj8g5sbdliof6.apps.googleusercontent.com',
    iosBundleId: 'com.example.bookingApp',
  );
}

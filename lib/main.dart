import 'package:firebase78/google_signin.dart';
import 'package:firebase78/operation.dart';
import 'package:firebase78/read.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  // await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAkm4Iwxhbdn_5bu8niZC77TaVHMWC9sCo",
      appId: "1:582448496370:android:e258c1f86f486b38d55a6b",
      authDomain: "batch-80.firebaseapp.com",
      databaseURL: "https://{batch-80}.firebaseio.com",
      messagingSenderId: "582448496370",
      projectId: "batch-80",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ReadFirebase(),
      home: AllOperation(),
      // home: SignInPage(),
    );
  }
}


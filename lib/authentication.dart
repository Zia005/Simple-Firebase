import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
        await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e.toString()+"1");
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            print(e.code.toString()+"2");
          } else if (e.code == 'invalid-credential') {
            print(e.code.toString()+"3");
          }
        } catch (e) {
          print(e.toString()+"4");
        }
      }
    }
    
    // USE THIS LINE IN ANY ONPRESSED METHOD
    // User? user = await Authentication.signInWithGoogle(context: context);
    return user;
  }

  static Future signUP(String email, String password,) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // FirebaseFirestore operationFirestore = FirebaseFirestore.instance;

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // operationFirestore.collection("Cool").doc(user.user!.uid.toString()).set({
      //   "Email": email,
      //   "Password": password,
      //   "Username" : user.user!.displayName.toString(),
      // });

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future signIn({required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // if(_globalKey.currentState!.validate()){
  //   Authentication
  //     .signIn(email: nameController.text, password: passwordController.text)
  //     .then((result) {
  //       if (result == null) {
  //         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  //       } else {
  //         Scaffold.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //             result,
  //           style: TextStyle(fontSize: 16),
  //           ),
  //         ));
  //       }
  //     }
  //   );
  // }

  // if(_globalKey.currentState!.validate()){
  //   Authentication
  //     .signUP(nameController.text, passwordController.text,)
  //     .then((result) {
  //       if (result == null) {
  //
  //       } else {
  //         Scaffold.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //             result,
  //             style: TextStyle(fontSize: 16),
  //           ),
  //         ));
  //       }
  //   });
  // }
}
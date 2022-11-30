// https://bizalert-bc82e.firebaseapp.com/__/auth/handler
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthentication {
  // Creaating Custom SnackBar
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<bool> initializeFirebase(
      // {required BuildContext context}
      ) async {
    // FirebaseApp firebaseApp = await Firebase.initializeApp();
    // // print(firebaseApp);

    // User? user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    //   Navigator.popAndPushNamed(context, DashboardScreen.routeName);
    // }

    return true;
  }

  // Google SignIn

  static Future<GoogleSignInAccount?> signInWithGoogle(
      {required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignInAccount? googleSignInAccount;
    if (kIsWeb) {
      // For Web
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);
        User? user = userCredential.user;
        log(user!.uid);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignInAccount = await googleSignIn.signIn();
      // if (googleSignInAccount != null) {
      //   final GoogleSignInAuthentication googleSignInAuthentication =
      //       await googleSignInAccount.authentication;
      //   final AuthCredential credential = GoogleAuthProvider.credential(
      //     accessToken: googleSignInAuthentication.accessToken,
      //     idToken: googleSignInAuthentication.idToken,
      //   );
      //   try {
      //     final UserCredential userCredential =
      //         await auth.signInWithCredential(credential);
      //     // user = userCredential.user;
      //     if (userCredential.additionalUserInfo!.isNewUser) {
      //       // Register new user
      //     } else {
      //       //Ex: Go to HomePage()
      //     }
      //   } on FirebaseAuthException catch (e) {
      //     if (e.code == 'account-exists-with-different-credential') {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         FirebaseAuthentication.customSnackBar(
      //           content:
      //               'The account already exists with a different credential',
      //         ),
      //       );
      //     } else if (e.code == 'invalid-credentail') {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         FirebaseAuthentication.customSnackBar(
      //           content:
      //               'Error occurred while accessing credentials. Try again.',
      //         ),
      //       );
      //     }
      //   } catch (e) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       FirebaseAuthentication.customSnackBar(
      //         content: 'Error occurred using Google Sign In. Try again.',
      //       ),
      //     );
      //   }
      // }
    }
    return googleSignInAccount;
  }

  // static Future<void> signOut({required BuildContext context}) async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   try {
  //     if (!kIsWeb) {
  //       await googleSignIn.signOut();
  //     }
  //     await FirebaseAuth.instance.signOut();
  //   } catch (e) {
  // ScaffoldMessenger.of(context).showSnackBar(
  //   FirebaseAuthentication.customSnackBar(
  //     content: 'Error signing out. Try again.',
  //   ),
  // );
  //   }
  // }

}

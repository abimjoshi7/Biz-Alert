import 'package:biz_alert/features/signup_page/services/dio_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  final socialAuth = DioSocialSignUp();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      await socialAuth.registerNewSocialUser(
        email: _firebaseAuth.currentUser?.email ?? "",
        firstName: _firebaseAuth.currentUser?.displayName ?? "",
        lastName: "",
        mobileNumber: _firebaseAuth.currentUser?.phoneNumber ?? "",
        password: "",
        sexType: "",
        socialStatus: 2,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await _firebaseAuth.signInWithCredential(credential);
        await socialAuth.registerNewSocialUser(
          email: _firebaseAuth.currentUser?.email ?? "",
          firstName: _firebaseAuth.currentUser?.displayName ?? "",
          lastName: "",
          mobileNumber: _firebaseAuth.currentUser?.phoneNumber ?? "",
          password: "",
          sexType: "",
          socialStatus: 1,
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

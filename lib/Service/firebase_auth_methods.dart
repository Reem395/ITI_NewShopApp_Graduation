import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../ViewModels/Local/CacheHelper.dart';
import '../ViewModels/constants.dart';
import '../utils/showOtpDialog.dart';
import '../utils/showSnackbar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  User? get user => _auth.currentUser;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

// PHONE SIGN IN
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        showSnackBar(context, e.message!);
      },
      codeSent: ((String verificationId, int? resendToken) async {
        showOTPDialog(
          codeController: codeController,
          context: context,
          onPressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: codeController.text.trim(),
            );
            await _auth.signInWithCredential(credential);
            Navigator.of(context).pop();
            print("User data = $user");
            FirebaseFirestore.instance
                .collection('Users')
                .where('userId', isEqualTo: user?.uid)
                .snapshots()
                .listen((data) {
              if (data.docs.isEmpty) {
                FirebaseFirestore.instance.collection('Users').add({
                  'userId': user?.uid,
                  'email': null,
                  'name': null,
                  'phone': phoneNumber,
                  'state': null,
                  'city': null,
                  'description': null,
                  "password": null
                });
              }
            });
          },
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {}
        }
      }

      print("User data = $user");
      CacheHelper.setData(key: "uId", value: user?.uid);
      uId= user?.uid;
      FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: user?.uid)
          .snapshots()
          .listen((data) {
        if (data.docs.isEmpty) {
          FirebaseFirestore.instance.collection('Users').add({
            'userId': user?.uid,
            'email': user?.email,
            'name': user?.displayName,
            'phone': null,
            'state': null,
            'city': null,
            'description': null,
            "password": null
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

// FACEBOOK SIGN IN
  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      var data = await FacebookAuth.instance.getUserData();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential);
      print("User data = $user");
      CacheHelper.setData(key: "uId", value: user?.uid);
      uId= user?.uid;
      FirebaseFirestore.instance
          .collection('Users')
          .where('userId', isEqualTo: user?.uid)
          .snapshots()
          .listen((data) {
        if (data.docs.isEmpty) {
          FirebaseFirestore.instance.collection('Users').add({
            'userId': user?.uid,
            'email': user?.email,
            'name': user?.displayName,
            'phone': null,
            'state': null,
            'city': null,
            'description': null,
            "password": null
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/utils/messengers.dart';

class AuthRepo {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static Stream<User?> get authChanges => _auth.authStateChanges();

  static User? get currentUser => _auth.currentUser;

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        googleProvider.addScope('https://www.googleapis.com/auth/userinfo.profile');
        final userCredential = await _auth.signInWithPopup(googleProvider);
        final isNewUser = userCredential.additionalUserInfo!.isNewUser;
        final user = userCredential.user;
        if (isNewUser && user != null) {
          await _firestore.collection('members').doc(user.uid).set({
            'uid': user.uid,
            'name': user.displayName,
            'imageURL': user.photoURL,
            'email': user.email,
            'scores': []
          });
        }
      }
    } catch (e) {
      Messengers.showSnackBar(context, message: e.toString());
    }
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      _auth.signOut();
    } catch (e) {
      Messengers.showSnackBar(context, message: e.toString());
    }
  }
}
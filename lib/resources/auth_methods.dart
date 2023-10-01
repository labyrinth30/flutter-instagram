import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_instagram/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign up user
  Future<String> signUpUser({
    required String username,
    required String bio,
    required String email,
    required String passsword,
    required Uint8List file,
  }) async {
    String result = "Some error occurred";
    try {
      if (username.isNotEmpty &&
          bio.isNotEmpty &&
          email.isNotEmpty &&
          passsword.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: passsword);
        final uid = cred.user!.uid;
        print(uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user to our database
        await _firestore.collection('users').doc(uid).set({
          'username': username,
          'uid': uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        result = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        result = 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        result = 'Password should be at least 6 characters';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  // loggin in user
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Some error occurred';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'success';
      } else {
        result = 'Please enter all the fields';
      }
    } on FirebaseException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        result = 'login failure';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }
}

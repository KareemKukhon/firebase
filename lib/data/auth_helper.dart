import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_18_firebase/data/firestore_helper.dart';
import 'package:flutter_application_18_firebase/main.dart';
import 'package:flutter_application_18_firebase/router/router.dart';

import '../screens/sign_in.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth. createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  updateProfile(String email) async {
    try {
      await firebaseAuth.currentUser?.updateEmail(email);
      //await firebaseAuth.currentUser?.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  checkUser() async {
    User? user = await firebaseAuth.currentUser;

    return user?.uid;
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  forgetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      log("check your email");
    } on Exception catch (e) {
      // TODO
      log(e.toString());
    }
  }
}

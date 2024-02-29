import 'dart:developer';

import 'package:e_commerce_app/features/home/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterRepo {
  Future<void> registerUser(UserModel userModel, String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      // final userCredential =
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );
      user.updateDisplayName(userModel.fullName);
      createUserDocument(userModel);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> createUserDocument(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.email)
          .set(userModel.toMap());
    } catch (e) {
      log(e.toString());
    }
  }
}

import 'dart:developer';

import 'package:e_commerce_app/features/home/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterRepo {
  Future<String> registerUser(UserModel userModel, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );
     await createUserDocument(userModel);
      return "";
    } catch (e) {
      log(e.toString());
      return e.toString();
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

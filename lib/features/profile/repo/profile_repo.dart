import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/home/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepo {
  Future<UserModel> getUserInfo() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();
    log("Func called");
    final data = doc.data() as Map<String, dynamic>;
    log(UserModel.fromMap(data).toString());
    return UserModel.fromMap(data);
  }
}

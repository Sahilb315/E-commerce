import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/home/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRepo {
  Future<UserModel> getUserInfo() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get();

    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }
}

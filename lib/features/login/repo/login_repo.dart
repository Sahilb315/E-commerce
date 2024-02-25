import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
    }
  }
}

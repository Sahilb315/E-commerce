import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  Future<String?> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } catch (e) {
      log(e.toString());
      // Returning error if the user is not successfully logged in & has an error
      return e.toString();
    }
  }
}

import 'package:e_commerce_app/utils/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Text(
          "Profile",
          style: MyTextThemes.myTextTheme().titleMedium,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to the Profile Page!'),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }
}

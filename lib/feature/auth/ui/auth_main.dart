import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/feature/auth/ui/sign_in.dart';
import 'package:movie_app/feature/google_navbar.dart';

class AuthMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const GNavBar();
        } 
        return const SignInScreen();
      }
    );
  }
}

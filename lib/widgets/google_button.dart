import 'package:caparrots_initial/screens/home_screen.dart';
import 'package:caparrots_initial/screens/login_screen.dart';
import 'package:caparrots_initial/screens/mapa_screen.dart';
import 'package:caparrots_initial/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: GestureDetector(
        onTap: (() {
          _googleSignIn();
        }),
        child: Image.asset('assets/logo_google.png'),
      ),
    );
  }
}

_googleSignIn() async {
  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
}

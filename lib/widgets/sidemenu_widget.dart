import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Configuració'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.tornado_sharp),
          title: const Text('Calcetines'),
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, 'Calcetines');
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Tencar sessió'),
          onTap: () async {
            await GoogleSignIn().signOut();
            FirebaseAuth.instance.signOut();
          },
        )
      ]),
    );
  }
}

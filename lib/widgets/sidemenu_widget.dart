import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  List valores = [];
  List posiciones = [];
  SideMenu(this.valores, this.posiciones, {super.key});

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
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Configuració'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Tencar sessió'),
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        )
      ]),
    );
  }
}

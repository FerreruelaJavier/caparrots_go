import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
          leading: const Icon(Icons.shop),
          title: const Text('Tenda'),
          onTap: () {
            Navigator.pushNamed(context, 'Tenda');
          },
        ),
        ListTile(
          leading: const Icon(Icons.tornado_sharp),
          title: const Text('Mitjorns'),
          onTap: () {
            Navigator.pushNamed(context, 'Calcetin');
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

import 'package:caparrots_initial/providers/login_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});

  final TextEditingController _email = TextEditingController();

  final TextEditingController _constrasena = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(
          height: 100,
        ),
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/logotransparent.jpg',
            fit: BoxFit.cover,
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        fieldEmail(),
        const Divider(
          color: Colors.white,
        ),
        fieldPassword(context),
        const Divider(
          color: Colors.white,
        ),
        ElevatedButton(
          onPressed: (() {
            Navigator.pushNamed(context, 'map');
            signIn();
          }),
          child: const Text('LOG IN'),
        ),
        const SizedBox(
          height: 170,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No tens compte?',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'SignUp');
              },
              child: const Text(
                'Clica aqui!!',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget fieldEmail() {
    return SizedBox(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _email,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) => email != null && EmailValidator.validate(email)
            ? null
            : 'Introdueix un email valid',
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(50.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget fieldPassword(BuildContext context) {
    final passwProvider = Provider.of<LoginProvider>(context);

    return SizedBox(
      width: 350,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (valor) => valor != null && valor.length < 6
            ? 'Introdueix un minim de 6 caracters'
            : null,
        controller: _constrasena,
        obscureText: passwProvider.password,
        onChanged: (value) {},
        decoration: InputDecoration(
          labelText: 'Contrasenya',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(50.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(passwProvider.password
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded),
            onPressed: () {
              passwProvider.actualizarContra();
            },
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _constrasena.text.trim());
    } on FirebaseAuthException {
      Utils.showSnackBar("El email o la contrasenya no son correctes");
    }
  }
}

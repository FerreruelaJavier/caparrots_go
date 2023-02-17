import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../utils/utils.dart';

class RegisterWidget extends StatelessWidget {
  RegisterWidget({super.key});

  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _constrasena = TextEditingController();

  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registrarse'),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 30, 10),
                child: Text(
                  'Rellena el seguents camps:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              fieldName(),
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
                  signUp();
                }),
                child: const Text('Registarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldName() {
    return SizedBox(
      width: 350,
      child: TextFormField(
        controller: _name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          if (text!.isEmpty) {
            return "El nom és obligatori";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Nom d\'usuari',
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
        onChanged: (value) {},
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

  Future signUp() async {
    final esValid = _key.currentState!.validate();
    if (!esValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(), password: _constrasena.text.trim());
    } on FirebaseAuthException {
      Utils.showSnackBar("El mail que ha introduit ja existeix");
    }
  }
}

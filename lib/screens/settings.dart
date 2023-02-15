import 'dart:ui';

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  double _volumeValue = 0;

  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool dm = false;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Change Username',
                style: TextStyle(fontSize: 20),
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              Row(
                children: [
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'UserName',
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.check), onPressed: () => {})
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              SizedBox(
                width: 350,
                child: Text(
                    'Si te gustaria cambiar tu nombre de usuario aqui podras hacerlo.'),
              ),
              Divider(),
              Text('Volume'),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              Slider(
                  value: _volumeValue,
                  onChanged: (newVol) async {
                    _volumeValue = newVol;
                  }),
              Padding(padding: EdgeInsets.only(bottom: 15)),
              Text('Selecciona el volumen deseado'),
              Divider(),
              Center(
                child: Row(
                  children: [
                    Text('Enable Dark Mode'),
                    Switch(
                      value: dm,
                      onChanged: (bool newDarkMode) {
                        newDarkMode = dm;
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tienda de Sa Pobla"),
        actions: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.monetization_on),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Dinero Actual"),
                    content: Text("Tienes 0 CapaCoins"), // actualizar monedas
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/c0/ab/a7/c0aba72df4ddbc3aaae3faba8f77f0fe.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(Icons.sticky_note_2_sharp),
            title: Text("Baston Caparrot"),
            subtitle: Text("20 de daño"),
            trailing: Container(
              width: 100,
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmar compra"),
                            content: Text(
                                "El articulo vale 20 CapaCoins, confirmar compra?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Confirmar"),
                                onPressed: () {
                                  // Comprar
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.blue,
                    child: Text(
                      "Comprar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.face),
            title: Text("Mascara Caparrot"),
            subtitle: Text("20 de defensa"),
            trailing: Container(
              width: 100,
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmar compra"),
                            content: Text(
                                "El articulo vale 20 CapaCoins, confirmar compra?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Confirmar"),
                                onPressed: () {
                                  // Comprar
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.blue,
                    child: Text(
                      "Comprar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.face_2),
            title: Text("Super Mascara Caparrot"),
            subtitle: Text("40 de defensa"),
            trailing: Container(
              width: 100,
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmar compra"),
                            content: Text(
                                "El articulo vale 40 CapaCoins, confirmar compra?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Confirmar"),
                                onPressed: () {
                                  // Comprar
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.blue,
                    child: Text(
                      "Comprar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.stairs_sharp),
            title: Text("Super Baston Caparrot"),
            subtitle: Text("40 de ataque"),
            trailing: Container(
              width: 100,
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmar compra"),
                            content: Text(
                                "El articulo vale 40 CapaCoins, confirmar compra?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Confirmar"),
                                onPressed: () {
                                  // Comprar
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.blue,
                    child: Text(
                      "Comprar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.question_mark),
            title: Text("LootBox"),
            subtitle: Text("Buena Suerte Bro"),
            trailing: Container(
              width: 100,
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmar compra"),
                            content: Text(
                                "El articulo vale 100 CapaCoins, confirmar compra?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Confirmar"),
                                onPressed: () {
                                  // Comprar
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.blue,
                    child: Text(
                      "Comprar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

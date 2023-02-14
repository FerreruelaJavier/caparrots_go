import 'package:flutter/material.dart';

class CalcetinesScreen extends StatelessWidget {
  const CalcetinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Coleccionables'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          minRadius: 40.0,
                          maxRadius: 55.5,
                          backgroundImage: NetworkImage(
                              "https://via.placeholder.com/100.png/04f/fff"),
                          backgroundColor: Colors.transparent,
                        ),
                        Text('Calcetin 1')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          minRadius: 40.0,
                          maxRadius: 55.5,
                          backgroundImage: NetworkImage(
                              "https://via.placeholder.com/100.png/04f/fff"),
                          backgroundColor: Colors.transparent,
                        ),
                        Text('Calcetin 2')
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          minRadius: 40.0,
                          maxRadius: 55.5,
                          backgroundImage: NetworkImage(
                              "https://via.placeholder.com/100.png/04f/fff"),
                          backgroundColor: Colors.transparent,
                        ),
                        Text('Calcetin 3')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          minRadius: 40.0,
                          maxRadius: 55.5,
                          backgroundImage: NetworkImage(
                              "https://via.placeholder.com/100.png/04f/fff"),
                          backgroundColor: Colors.transparent,
                        ),
                        Text('Calcetin 4')
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          minRadius: 40.0,
                          maxRadius: 55.5,
                          backgroundImage: NetworkImage(
                              "https://via.placeholder.com/100.png/04f/fff"),
                          backgroundColor: Colors.transparent,
                        ),
                        Text('Calcetin 5')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          minRadius: 40.0,
                          maxRadius: 55.5,
                          backgroundImage: NetworkImage(
                              "https://via.placeholder.com/100.png/04f/fff"),
                          backgroundColor: Colors.transparent,
                        ),
                        Text('Calcetin 6')
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    minRadius: 40.0,
                    maxRadius: 55.5,
                    backgroundImage: NetworkImage(
                        "https://via.placeholder.com/100.png/04f/fff"),
                    backgroundColor: Colors.transparent,
                  ),
                  Text('Calcetin 7')
                ],
              ),
              Padding(padding: EdgeInsets.all(20))
            ],
          ),
        ),
      ),
    );
  }
}

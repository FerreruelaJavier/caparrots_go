import 'package:caparrots_initial/providers/camera_provider.dart';
import 'package:flutter/material.dart';
import 'package:caparrots_initial/providers/login_provider.dart';
import 'package:caparrots_initial/screens/screens.dart';
import 'package:caparrots_initial/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/map_screen.dart';
import 'screens/mapa_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CameraProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Practica 4.1',
      home: const HomeScreen(),
      routes: {
        'Home': (context) => const HomeScreen(),
        'SignIn': (context) => const SignInScreen(),
        'SignUp': (context) => const SignUpScreen(),
        'Caparrots': (context) => CaparrotWidget(),
        'map': (_) => MapaScreen(),
      },
      theme: ThemeData.light(),
    );
  }
}

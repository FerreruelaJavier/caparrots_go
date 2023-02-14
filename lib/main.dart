// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:caparrots_initial/screens/screens.dart';
import 'package:caparrots_initial/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';

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
        'SignIn': (context) => SignInScreen(),
        'SignUp': (context) => SignUpScreen(),
        'Caparrots': (context) => const CaparrotScreen(),
        'map': (_) => const MapaScreen(),
      },
      theme: ThemeData.light(),
    );
  }
}

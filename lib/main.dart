// ignore: depend_on_referenced_packages
import 'package:caparrots_initial/firebase_options.dart';
import 'package:caparrots_initial/screens/shop_screen.dart';
import 'package:caparrots_initial/screens/tutorial_screen.dart';
import 'package:flutter/material.dart';
import 'package:caparrots_initial/providers/login_provider.dart';
import 'package:caparrots_initial/screens/screens.dart';
import 'package:caparrots_initial/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'screens/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CameraProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FireBaseProvider(),
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
      home: CaparrotScreen(),
      routes: {
        'Home': (context) => const HomeScreen(),
        'Caparrots': (context) => const CaparrotScreen(),
        'Calcetin': (context) => const CalcetinesScreen(),
        'Settings': (context) => SettingsScreen(),
        'Map': (context) => const MapaScreen(),
        'Tenda': (context) => const ShopScreen(),
        'Tutorial': (context) => const TutorialScreen(),
      },
    );
  }
}

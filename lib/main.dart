import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation/providers/providers.dart';
import 'package:home_automation/screens/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Automation',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        splash: 'assets/logo.png',
        splashIconSize: 100,
        nextScreen: const HomeScreen(),
      ),
    );
  }
}

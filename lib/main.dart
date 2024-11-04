import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/firebase_options.dart';
import 'package:nexus_ranking_system/screens/home.dart';
import 'package:nexus_ranking_system/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.darkTheme,
      home: HomeScreen(),
    );
  }
}
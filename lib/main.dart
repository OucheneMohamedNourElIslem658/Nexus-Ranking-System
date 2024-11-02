import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/rank/screens/rank.dart';
import 'package:nexus_ranking_system/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.darkTheme,
      home: const RankScreen(),
    );
  }
}
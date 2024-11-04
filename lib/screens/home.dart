import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nexus_ranking_system/features/admin/screens/landing.dart';

import 'package:nexus_ranking_system/features/auth/repos/auth.dart';
import 'package:nexus_ranking_system/features/auth/screens/auth.dart';
import 'package:nexus_ranking_system/features/rank/screens/rank.dart';
import 'package:nexus_ranking_system/commun/screens/waiting.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return StreamBuilder<User?>(
        stream: AuthRepo.authChanges, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingScreen();
          }
          final user = snapshot.data;
          if (user != null) {
            return const RankScreen();
          }
          return const AuthScreen();
        },
      );
    } else {
      return const AdminBoard();
    }
  }
}